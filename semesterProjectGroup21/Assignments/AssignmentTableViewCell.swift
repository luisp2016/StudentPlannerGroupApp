//
//  AssignmentTableViewCell.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    var isChosen: Bool = false
    static let rowHeight = CGFloat(70.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tapStatusButton(_ sender: Any) {
        if isChosen {
            statusButton.setImage(UIImage(named: "boxUnchecked"), for: .normal)
            isChosen = false
        } else {
            statusButton.setImage(UIImage(named: "boxChecked"), for: .normal)
            isChosen = true
        }
    }
}
