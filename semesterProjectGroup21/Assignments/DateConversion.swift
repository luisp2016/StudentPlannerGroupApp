//
//  DateConversion.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 5/14/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import Foundation

func convertDate(_ input: String) -> String? {
    let regex = try! NSRegularExpression(pattern: "\\d{2}(\\d{2})-(\\d+)-(\\d+)[.]*",
                                         options: [])
    let match = regex.firstMatch(in: input,
                                 options: [],
                                 range: NSRange(location: 0, length: input.count))

    guard match != nil else {return nil}
    
    let yearRange: NSRange = match!.range(at: 1)
    let year: String = String(input[Range(yearRange, in: input)!])
    
    let monthRange: NSRange = match!.range(at: 2)
    let month: String = String(input[Range(monthRange, in: input)!])
    
    let dayRange: NSRange = match!.range(at: 3)
    let day: String = String(input[Range(dayRange, in: input)!])
    
    return String(month + "/" + day + "/" + year)
}
