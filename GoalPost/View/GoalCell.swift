//
//  GoalCell.swift
//  GoalPost
//
//  Created by badal shah on 02/02/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var lblGoal: UILabel!
    @IBOutlet weak var lblGoalDescription: UILabel!
    @IBOutlet weak var lblGoalProgress: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configureCell (goal: Goal) {
        self.lblGoal.text = goal.goalDescription
        self.lblGoalDescription.text = goal.goalType
        self.lblGoalProgress.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalComplitionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
    
}
