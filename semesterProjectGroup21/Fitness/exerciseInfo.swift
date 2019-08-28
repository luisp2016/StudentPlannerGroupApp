//
//  exerciseInfo.swift
//  semesterProjectGroup21
//
//  Created by Andre Andrada on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import Foundation

class Exercise {
    var name = String()
    var day = String()
    var sets = String()
    var reps = String()
    var weightUsed = String()
    var description = String()
    
    init(name: String, day: String, sets: String, reps: String, weightUsed: String, description: String) {
        self.name = name
        self.day = day
        self.sets = sets
        self.reps = reps
        self.weightUsed = weightUsed
        self.description = description
    }
}
