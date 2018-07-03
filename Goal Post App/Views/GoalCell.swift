//
//  GoalCell.swift
//  Goal Post App
//
//  Created by Oforkanji Odekpe on 7/3/18.
//  Copyright © 2018 Oforkanji Odekpe. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    
    func configureCell(goal: Goal){
        self.goalDescriptionLabel.text = goal.goalDescription
        self.goalTypeLabel.text = goal.goalType
        self.goalProgressLabel.text = String(describing: goal.goalProgress)
    }
}
