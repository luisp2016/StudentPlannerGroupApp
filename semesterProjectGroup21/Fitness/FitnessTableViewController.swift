//
//  FitnessTableViewController.swift
//  semesterProjectGroup21
//
//  Created by Andre Andrada on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit

var sun1 = Exercise(name: "Bench Press", day: "Sunday", sets: "5", reps: "5", weightUsed: "210", description: "Lift heavy weight")
var mon1 = Exercise(name: "Deadlift", day: "Monday", sets: "5", reps: "5", weightUsed: "300", description: "")
var tue1 = Exercise(name: "Sprints", day: "Tuesday", sets: "-", reps: "-", weightUsed: "", description: "Run for 30s, walk for 60s")
var wed1 = Exercise(name: "Military Press", day: "Wednesday", sets: "4", reps: "12", weightUsed: "30", description: "Strict")

var thur1 = Exercise(name: "Squats", day: "Thursday", sets: "5", reps: "10", weightUsed: "150", description: "Go low enough")

var fri1 = Exercise(name: "Bicep Curls", day: "Friday", sets: "5", reps: "12", weightUsed: "20", description: "Arm dayyy")

var sat1 = Exercise(name: "5-mile run", day: "Saturday", sets: "-", reps: "-", weightUsed: "", description: "Go around campus")
var absEx = Exercise(name: "Situps", day: "Sunday", sets: "3", reps: "20", weightUsed: "", description: "")



var sunEx = [sun1, absEx]
var monEx = [mon1]
var tueEx = [tue1]
var wedEx = [wed1]
var thurEx = [thur1]
var friEx = [fri1]
var satEx = [sat1]

//var sunEx = [ex1]
//var monEx = ["Squat"]
//var tueEx = ["Sprints"]
//var wedEx = ["Deadlift"]
//var thurEx = ["Bench"]
//var friEx = ["Leg Press"]
//var satEx = ["Another Exercise"]

var totalEx = sunEx + monEx + tueEx + wedEx + thurEx + friEx + satEx

var myIndex = 0
var mySection = 0

class FitnessTableViewController: UITableViewController {
    
    let cellId = "cellId"
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    
//    var totalEx = ["Bench Press", "Squat", "Sprints", "Deadlift", "Bench", "Leg Press", "Another Exercise"]
//    var sunEx = ["Bench Press"]
//    var monEx = ["Squat"]
//    var tueEx = ["Sprints"]
//    var wedEx = ["Deadlift"]
//    var thurEx = ["Bench"]
//    var friEx = ["Leg Press"]
//    var satEx = ["Another Exercise"]
//
//    var totalEx = sunEx + self.monEx + self.tueEx + self.wedEx + self.thurEx + self.friEx + self.satEx

    
    @IBAction func addExercise(_ sender: Any) {
        let vc: ExerciseViewController = ExerciseViewController()
        
            self.tableView.reloadData()
           print("about to enter the form")
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.reloadData()
        self.viewDidLoad()
        print("im getting here")
        print(monEx.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = "Sunday"
        } else if section == 1 {
            label.text = "Monday"
        } else if section == 2 {
            label.text = "Tuesday"
        } else if section == 3 {
            label.text = "Wednesday"
        } else if section == 4 {
            label.text = "Thursday"
        } else if section == 5 {
            label.text = "Friday"
        } else if section == 6 {
            label.text = "Saturday"
        }
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
//        if section == 0 {
//            return totalEx.count
//        }
        if section == 0 {
            return sunEx.count
        } else if section == 1 {
            return monEx.count
        } else if section == 2 {
            return tueEx.count
        } else if section == 3 {
            return wedEx.count
        } else if section == 4 {
            return thurEx.count
        } else if section == 5 {
            return friEx.count
        } else if section == 6 {
            return satEx.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        if indexPath.section == 0 { //Sunday
            sunEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if indexPath.section == 1 { //Monday
            monEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        } else if indexPath.section == 2 { //Tuesday
            tueEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)


        } else if indexPath.section == 3 { //Wednesday
            wedEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)


        } else if indexPath.section == 4 { //Thursday
            thurEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)


        } else if indexPath.section == 5 { //Friday
            friEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)


        } else if indexPath.section == 6 { //Saturday
            satEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)


        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        var name = ""
        var sets = ""
        var reps = ""

//        let name = self.days[indexPath.row]
        if indexPath.section == 0 { //Sunday
            name = sunEx[indexPath.row].name
            sets = sunEx[indexPath.row].sets
            reps = sunEx[indexPath.row].reps
        } else if indexPath.section == 1 { //Monday
            name = monEx[indexPath.row].name
            sets = monEx[indexPath.row].sets
            reps = monEx[indexPath.row].reps
        } else if indexPath.section == 2 { //Tuesday
            name = tueEx[indexPath.row].name
            sets = tueEx[indexPath.row].sets
            reps = tueEx[indexPath.row].reps
        } else if indexPath.section == 3 { //Wednesday
            name = wedEx[indexPath.row].name
            sets = wedEx[indexPath.row].sets
            reps = wedEx[indexPath.row].reps
        } else if indexPath.section == 4 { //Thursday
            name = thurEx[indexPath.row].name
            sets = thurEx[indexPath.row].sets
            reps = thurEx[indexPath.row].reps
        } else if indexPath.section == 5 { //Friday
            name = friEx[indexPath.row].name
            sets = friEx[indexPath.row].sets
            reps = friEx[indexPath.row].reps
        } else if indexPath.section == 6 { //Saturday
            name = satEx[indexPath.row].name
            sets = satEx[indexPath.row].sets
            reps = satEx[indexPath.row].reps
        }
        cell.textLabel?.text = name
//        cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row: \(indexPath.row)"
        cell.textLabel?.text = "\(name) Sets: \(sets) Reps: \(reps)"
        
        return cell
    }

    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        mySection = indexPath.section
        
        print("Floop")
        print(myIndex)
        print(mySection)
        
        performSegue(withIdentifier: "fitnessSegue", sender: self)
        self.viewDidLoad()
        print(monEx.count)
    }
    
    
}
