//
//  AssignmentsTableViewController.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit
import CoreData

class AssignmentsTableViewController: UITableViewController {
    var data: [Assignment]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        fetchData()
    }

    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.predicate = NSPredicate(format: "userID == %d", globalUserID)
        let student: Student = try! context.fetch(request).first!
        
        data = student.assignments?.sortedArray(using: [NSSortDescriptor.init(key: "date", ascending: true)]) as? [Assignment]
    }
    
    @IBAction func addItem(_ sender: Any) {
        // Display action sheet
        let optionMenu = UIAlertController(title: nil,
                                           message: "Choose an item.",
                                           preferredStyle: .actionSheet)
        
        optionMenu.addAction(UIAlertAction(title: "Assignment", style: .default) {
            _ in
            let vc: AssignmentEditViewController = AssignmentEditViewController()
            vc.tableViewData = self.data
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        optionMenu.addAction(UIAlertAction(title: "Course", style: .default) {
            _ in
            let coursevc: CourseViewController = CourseViewController()
            self.navigationController?.pushViewController(coursevc, animated: true)
        })
        
        optionMenu.addAction(UIAlertAction(title: "Project", style: .default) {
            _ in
            let projectvc: ProjectViewContoller = ProjectViewContoller()
            self.navigationController?.pushViewController(projectvc, animated: true)
        })
        
        optionMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(optionMenu, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchData()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! AssignmentTableViewCell

        // Configure the cell...
        cell.classLabel.text = data[indexPath.row].course?.name
        cell.titleLabel.text = data[indexPath.row].title
        
        // Process date
        if let date = data[indexPath.row].date {
            let components = Calendar.current.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year],
                                                             from: date)
            cell.dateLabel.text = String(components.month!) + "/" + String(components.day!) + "/" + String(components.year!)
        }
        
        cell.priorityLabel.text = data[indexPath.row].priority

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AssignmentTableViewCell.rowHeight
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AssignmentTableViewCell
        if cell.isChosen {
            cell.isChosen = false
            cell.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            cell.isChosen = true
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
    */
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = AssignmentEditViewController()
        vc.assignment = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
