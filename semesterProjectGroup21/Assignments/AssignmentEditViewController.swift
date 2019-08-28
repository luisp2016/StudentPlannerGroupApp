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

class AssignmentEditViewController: FormViewController {
    var tableViewData: [Assignment]!
    var assignment: Assignment!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleRow = TextRow() {
            $0.title = "Title"
            
            if assignment != nil {
                $0.value = assignment.title
            } else {
                $0.placeholder = "Enter title here"
            }
        }
        
        let courseRow = PushRow<String>() {
            $0.title = "Course"
            
            // fetch project names
            $0.options = fetchCourses()

            $0.value = assignment != nil ? (assignment!.course?.name ?? "None") : "None"
            }.onPresent {from, to in
                to.dismissOnSelection = true
        }
        
        let projectRow = PushRow<String>() {
            $0.title = "Project"
            
            // fetch project names
            $0.options = fetchProjects()

            $0.value = assignment != nil ? (assignment!.project?.title ?? "None") : "None"
            }.onPresent {from, to in
                to.dismissOnSelection = true
        }
        
        let priorityRow = SegmentedRow<String>() {
            $0.title = "Priority         "
            $0.options = ["None", "!", "!!", "!!!"]
            $0.value = assignment != nil ? assignment!.priority?.description : "None"
            }
        
        let dateNeededRow = SwitchRow("switchTag1") {
            $0.title = "Remind me on a day"
            
            if assignment != nil {
                $0.value = true
            }
        }
        
        let dateRow = DateInlineRow() {
            $0.hidden = Condition.function(["switchTag1"], { form in
                return !((form.rowBy(tag: "switchTag1") as? SwitchRow)?.value ?? false)
            })
            
            $0.title = "Due Date"
            
            if assignment != nil {
                $0.value = assignment!.date
            }
        }
        
        let descriptionRow = TextAreaRow() {
            if assignment == nil {
                $0.placeholder = "Description"
            } else {
                $0.value = assignment!.info
            }
        }
        
        let submitRow = ButtonRow() {
            $0.title = "Submit"
            }.onCellSelection {cell, row in
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let studentRequest: NSFetchRequest<Student> = Student.fetchRequest()
                studentRequest.predicate = NSPredicate(format: "userID == %d", globalUserID)
                let studentObject: Student! = try! context.fetch(studentRequest).first
                
                let assignment: Assignment = Assignment(context: context)
                assignment.title = titleRow.value
                
                if courseRow.value != "None" {
                    assignment.course = studentObject.courses?.filtered(using: NSPredicate(format: "name == %@", courseRow.value!)).first as? Course
                }
                
                if projectRow.value != "None" {
                    assignment.project = studentObject.projects?.filtered(using: NSPredicate(format: "title == %@", projectRow.value!)).first as? Project
                }
                
                if priorityRow.value != "None" {
                    assignment.priority = priorityRow.value
                }
                
                if dateNeededRow.value == true {
                    assignment.date = dateRow.value
                }
                
                if descriptionRow.value != nil {
                    assignment.info = descriptionRow.value
                }
                
                // assignment.student = studentObject
                studentObject.addToAssignments(assignment)
                
                // Save objects
                do {
                    try context.save()
                    // people.append(person) - for table view
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
                
                // Pop scene off stack
                self.navigationController?.popViewController(animated: true)
            }
        
        form +++ Section("Assignment Info")
            <<< titleRow
            <<< courseRow
            <<< projectRow
            <<< priorityRow
            <<< dateNeededRow
            <<< dateRow
            <<< descriptionRow
            <<< submitRow
    }
    
    func fetchProjects() -> [String] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.predicate = NSPredicate(format: "userID == %d", globalUserID)
        let student: Student = try! context.fetch(request).first!
        
        return (student.projects?.sortedArray(using: [NSSortDescriptor.init(key: "title", ascending: true)]) as? [Project])!.map({$0.title!})
    }
    
    func fetchCourses() -> [String] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.predicate = NSPredicate(format: "userID == %d", globalUserID)
        let student: Student = try! context.fetch(request).first!
        
        return (student.courses?.sortedArray(using: [NSSortDescriptor.init(key: "name", ascending: true)]) as? [Course])!.map({$0.name!})
    }
}
