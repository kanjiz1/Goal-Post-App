//
//  FinishedGoalVC.swift
//  Goal Post App
//
//  Created by Oforkanji Odekpe on 7/3/18.
//  Copyright © 2018 Oforkanji Odekpe. All rights reserved.
//

import UIKit

class FinishedGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyboard()
        pointsTextField.delegate = self
    }

    @IBAction func createGoalButtonWasPressed(_ sender: Any) {
        //Pass Data into CoreData Goal Model
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
}
