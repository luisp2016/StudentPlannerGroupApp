//
//  SecondViewController.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 4/30/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit
import MBCalendarKit
import CoreData

class StudentCalendarViewController: CalendarViewController {

    var data: Dictionary<Date, [CalendarEvent]> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        fetchDates()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchDates()
        self.tableView.reloadData()
    }

    override func calendarView(_ calendarView: CalendarView, eventsFor date: Date) -> [CalendarEvent] {
        let cleanDate = generateCleanDate(date)
        return self.data[cleanDate] ?? []
    }
    
    override func updateCacheWithSortedEvents() {
        //if ([self.dataSource respondsToSelector:@selector(calendarView:eventsForDate:)]) {
        self.events = self.data[generateCleanDate(self.calendarView.date)] ?? []
        //}
    }
    
    func fetchDates() -> Void {
        data.removeAll()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let studentRequest: NSFetchRequest<Student> = Student.fetchRequest()
        studentRequest.predicate = NSPredicate(format: "userID == %d", globalUserID)
        let studentObject: Student! = try! context.fetch(studentRequest).first
        
        for assignment in (studentObject.assignments?.sortedArray(using: [NSSortDescriptor.init(key: "date", ascending: true)]) as? [Assignment])! {
            if assignment.date != nil {
                
                let cleanDate = generateCleanDate(assignment.date!)
                
                let calEvent = CalendarEvent(title: assignment.title,
                                             andDate: cleanDate,
                                             andInfo: nil)!
                
                if data[cleanDate] != nil {
                    data[cleanDate]!.append(calEvent)
                } else {
                    data[cleanDate] = [calEvent]
                }
            }
        }
    }
    
    func generateCleanDate(_ date: Date) -> Date {
        print(date)
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: date)
        print("Day:\(components.day!) Month:\(components.month!) Year:\(components.year!)")
        let cleanDate = calendar.date(from: components)
        print(cleanDate!)
        return cleanDate!
    }
}
