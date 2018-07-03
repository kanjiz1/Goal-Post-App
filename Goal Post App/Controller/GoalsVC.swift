//
//  ViewController.swift
//  Goal Post App
//
//  Created by Oforkanji Odekpe on 7/3/18.
//  Copyright © 2018 Oforkanji Odekpe. All rights reserved.
//

import UIKit
import CoreData

struct Backup{
    var description: String!
    var goalType: String!
    var completionValue: Int32!
    var goalProgress: Int32!
}

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoView: UIView!
    
    var goals: [Goal] = []
    var backup: Backup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        undoView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if goals.count >= 1{
                tableView.isHidden = false
            } else{
                tableView.isHidden = true
            }
        }
    }

    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: CREATE_GOAL_VC) as? CreateGoalVC else {return}
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoButtonWasPressed(_ sender: Any) {
        undoDelete()
        undoView.isHidden = true
        tableView.reloadData()
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GOAL_CELL) as? GoalCell else {return UITableViewCell()}
        
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD ONE") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    
    func setProgress(atIndexPath indextPath: IndexPath){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indextPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else{
            return
        }
        do {
            try manageContext.save()
            print("Successfully set progress")
        } catch{
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    //Removing goal from Core Data
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}

        backup = Backup(description: goals[indexPath.row].goalDescription, goalType: goals[indexPath.row].goalType, completionValue: goals[indexPath.row].goalCompletionValue, goalProgress: goals[indexPath.row].goalProgress)
        
        manageContext.delete(goals[indexPath.row])
        
        do{
            try manageContext.save()
            print("Successfully removed goal")
            undoView.isHidden = false
        } catch{
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    //undo function
    func undoDelete(){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: manageContext)
        
        goal.goalDescription = backup.description
        goal.goalType = backup.goalType
        goal.goalCompletionValue = backup.completionValue
        goal.goalProgress = (backup.goalProgress)
        
        self.goals.append(goal)
        
        do {
            try manageContext.save()
            print("Successfully Undone")
        }
        catch let error as NSError {
            debugPrint("Something went Wrong: \(error.localizedDescription)")
        }
    }
    
    //Fetching Data from Core Data
    func fetch(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do{
            goals = try managedContext.fetch(fetchRequest)
            print("Successfully fetched Data")
            completion(true)
        } catch{
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}


