//
//  ExerciseViewController.swift
//  semesterProjectGroup21
//
//  Created by Andre Andrada on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class ExerciseViewController: FormViewController {
    
    var exToAdd = Exercise(name: "", day: "", sets: "", reps: "", weightUsed: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var exToAdd = Exercise(name: "", day: "", sets: "", reps: "", weightUsed: "", description: "")
        
        let nameRow = TextRow() {
//            $0.title = "Title"
//            $0.placeholder = "Enter title here"
            $0.title = "Name"
            $0.placeholder = "Enter name here"
            $0.onChange { [unowned self] row in
//                self.selectedCar = row.value!
                self.exToAdd.name = row.value!
            }
//            exToAdd.name = row.value!
        }
        
        let dayRow = PushRow<String>() {
            $0.title = "Day"
            $0.options = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            
            }.onPresent {from, to in
                to.dismissOnSelection = true
                
        }
        
        let setRow = PushRow<String>() {
            $0.title = "Sets"
            $0.options = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
            $0.value = "None"
            }.onPresent {from, to in
                to.dismissOnSelection = true
        }
        
        let repRow = PushRow<String>() {
            $0.title = "Reps"
            $0.options = []
            for i in 1...20 {
                $0.options?.append("\(i)")
            }
            $0.value = "None"
            }.onPresent {from, to in
                to.dismissOnSelection = true
        }
        
        let weightRow = IntRow() {
           
            $0.title = "Weight Used"
            $0.value = 0
            
//            $0.placeholder = ""
        }
        
        let descriptionRow = TextAreaRow() {
            $0.placeholder = "Description"
            
        }
        
        let submitRow = ButtonRow() {
            $0.title = "Submit"
            }.onCellSelection {cell, row in
                // Create object and save to core data
                print("im here bitch")
                
                if nameRow.value != nil {
                    self.exToAdd.name = nameRow.value!
                }
                if dayRow.value != nil {
                    self.exToAdd.day = dayRow.value!
                }
                if setRow.value != nil {
                    self.exToAdd.sets = setRow.value!

                }
                if repRow.value != nil {
                    self.exToAdd.reps = repRow.value!

                }
                if weightRow.value != nil {
                    self.exToAdd.weightUsed = String(weightRow.value!)

                }
                if descriptionRow.value != nil {
                    self.exToAdd.description = descriptionRow.value!
                }

                //                    print("fucker")
                //                    print(self.exToAdd.name)
        
                if (self.exToAdd.day == "Sunday") {
                    sunEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                if (self.exToAdd.day == "Monday") {
                    monEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                if (self.exToAdd.day == "Tuesday") {
                    tueEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                if (self.exToAdd.day == "Wednesday") {
                    wedEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                if (self.exToAdd.day == "Thursday") {
                    thurEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                if (self.exToAdd.day == "Friday") {
                    friEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                if (self.exToAdd.day == "Saturday") {
                    satEx.append(self.exToAdd)
                    self.tableView.reloadData()
                }
                
                print (monEx.count)
                
                self.tableView.reloadData()
                self.viewDidLoad()
                self.viewWillAppear(true)
                
                let vc2: FitnessTableViewController = FitnessTableViewController()
                vc2.tableView.reloadData()
                vc2.viewDidLoad()
                
                print("about to exit the form")
 self.navigationController?.popViewController(animated: true)
                
                
                
                
        }
        
        
        form +++ Section("Exercise Info")
            <<< nameRow
            <<< dayRow
            <<< setRow
            <<< repRow
            <<< weightRow
            <<< descriptionRow
            <<< submitRow
    }
}
