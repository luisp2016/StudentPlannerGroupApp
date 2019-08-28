//
//  AssignmentEditViewController.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class CourseViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildForm()
    }
    
    func buildForm() {
        // Currently existing projects
        var section1 = Section("Courses")
        
        let courses = fetchCourses()
        for name in courses {
            section1 = section1 <<< LabelRow() {
                $0.title = name
            }
        }
        
        var section2 = Section("Add a course")
        let titleRow = TextRow() {
            $0.title = "Title of course"
            $0.placeholder = "Enter title here"
        }
        let submitRow = ButtonRow() {
            $0.title = "Submit"
            }.onCellSelection {cell, row in
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let studentRequest: NSFetchRequest<Student> = Student.fetchRequest()
                studentRequest.predicate = NSPredicate(format: "userID == %d", globalUserID)
                let studentObject: Student! = try! context.fetch(studentRequest).first
                
                let course: Course = Course(context: context)
                course.name = titleRow.value
                
                studentObject.addToCourses(course)
                
                // Save objects
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
                // Refresh table
                self.buildForm()
                self.tableView.reloadData()
        }
        
        section2 = section2 <<< titleRow <<< submitRow
        
        form.removeAll()
        form +++ section1 +++ section2
    }
    
    func fetchCourses() -> [String] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.predicate = NSPredicate(format: "userID == %d", globalUserID)
        let student: Student = try! context.fetch(request).first!
        
        return (student.courses?.sortedArray(using: [NSSortDescriptor.init(key: "name", ascending: true)]) as? [Course])!.map({$0.name!})
    }
}
