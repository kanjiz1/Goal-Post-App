//
//  ViewController.swift
//  Goal Post App
//
//  Created by Oforkanji Odekpe on 7/3/18.
//  Copyright © 2018 Oforkanji Odekpe. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }

    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: CREATE_GOAL_VC) as? CreateGoalVC else {return}
        presentDetail(createGoalVC)
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GOAL_CELL) as? GoalCell else {return UITableViewCell()}
        
        cell.configureCell(description: "Eat Salad Twice a Week", type: .shortTerm, goalProgressAmount: 2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
