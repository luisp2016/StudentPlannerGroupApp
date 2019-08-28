//
//  ExerciseInfoViewController.swift
//  semesterProjectGroup21
//
//  Created by Andre Andrada on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit

class ExerciseInfoViewController: UIViewController {

    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var dayOutlet: UILabel!
    
    @IBOutlet weak var setsOutlet: UILabel!
    
    @IBOutlet weak var repsOutlet: UILabel!
    
    @IBOutlet weak var weightUsedOutlet: UILabel!
    
    @IBOutlet weak var descOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameOutlet.text = ""
    
        print (mySection)
        print (myIndex)
        
        if mySection == 0 { //Sunday
            nameOutlet.text = sunEx[myIndex].name
            dayOutlet.text = sunEx[myIndex].day
            setsOutlet.text = sunEx[myIndex].sets
            repsOutlet.text = sunEx[myIndex].reps
            weightUsedOutlet.text = sunEx[myIndex].weightUsed
            descOutlet.text = sunEx[myIndex].description
            print(sunEx[myIndex])
        } else if mySection == 1 { //Monday
            nameOutlet.text = monEx[myIndex].name
            dayOutlet.text = monEx[myIndex].day
            setsOutlet.text = monEx[myIndex].sets
            repsOutlet.text = monEx[myIndex].reps
            weightUsedOutlet.text = monEx[myIndex].weightUsed
            descOutlet.text = monEx[myIndex].description
        } else if mySection == 2 { //Tuesday
            nameOutlet.text = tueEx[myIndex].name
            dayOutlet.text = tueEx[myIndex].day
            setsOutlet.text = tueEx[myIndex].sets
            repsOutlet.text = tueEx[myIndex].reps
            weightUsedOutlet.text = tueEx[myIndex].weightUsed
            descOutlet.text = tueEx[myIndex].description
        } else if mySection == 3 { //Wednesday
            nameOutlet.text = wedEx[myIndex].name
            dayOutlet.text = wedEx[myIndex].day
            setsOutlet.text = wedEx[myIndex].sets
            repsOutlet.text = wedEx[myIndex].reps
            weightUsedOutlet.text = wedEx[myIndex].weightUsed
            descOutlet.text = wedEx[myIndex].description        } else if mySection == 4 { //Thursday
            nameOutlet.text = thurEx[myIndex].name
            dayOutlet.text = thurEx[myIndex].day
            setsOutlet.text = thurEx[myIndex].sets
            repsOutlet.text = thurEx[myIndex].reps
            weightUsedOutlet.text = thurEx[myIndex].weightUsed
            descOutlet.text = thurEx[myIndex].description        } else if mySection == 5 { //Friday
            nameOutlet.text = friEx[myIndex].name
            dayOutlet.text = friEx[myIndex].day
            setsOutlet.text = friEx[myIndex].sets
            repsOutlet.text = friEx[myIndex].reps
            weightUsedOutlet.text = friEx[myIndex].weightUsed
            descOutlet.text = friEx[myIndex].description        } else if mySection == 6 { //Saturday
            nameOutlet.text = satEx[myIndex].name
            dayOutlet.text = satEx[myIndex].day
            setsOutlet.text = satEx[myIndex].sets
            repsOutlet.text = satEx[myIndex].reps
            weightUsedOutlet.text = satEx[myIndex].weightUsed
            descOutlet.text = satEx[myIndex].description        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
