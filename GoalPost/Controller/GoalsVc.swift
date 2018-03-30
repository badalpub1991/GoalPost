//
//  GoalsVc.swift
//  GoalPost
//
//  Created by badal shah on 27/01/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

import UIKit
import CoreData

class GoalsVc: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var arrGoal:[Goal] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchCoreDataObjects()
        self.tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if arrGoal.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func adGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVc") else {return}
        presentDetail(createGoalVC) //With _
       // presentDetail(viewControllerToPresent: createGoalVC) // Without _
    }
    
}

extension GoalsVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGoal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as? GoalCell else {return UITableViewCell()}
        let goal = arrGoal[indexPath.row]
         cell.configureCell(goal: goal)
       // cell.configureCell(description: "Salad", type: "ShortTearm", goalProgressAmount: 100)
        
        return cell
    }
    //With this we can edit UITableview ex. Swipe to Delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Select tableview Editing Style (insert and Delete)-> if custom icon than set None
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    //Delete Action 1) Create delete Action 2) Remove data with Indexpath 3) fetch data from coredata 4) delete tableview row 4) set delete button background color 5) return deleteAction in arry wether it is single
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Destructive Because we want to delete(destroy) the data from tableview
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexpath) in
            self.removeGoal(atIndexPath: indexpath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexpath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexpath) in
            self.setProgress(atIndexpath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        return [deleteAction,addAction]
    }
}

extension GoalsVc {
    
    func setProgress(atIndexpath indexPath:IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
  
        let choosenGoal = arrGoal[indexPath.row]
        if choosenGoal.goalProgress < choosenGoal.goalComplitionValue {
            choosenGoal.goalProgress = choosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
             try managedContext.save()
        } catch {
            debugPrint("Could not set Progress: \(error.localizedDescription)")
        }
    }
    
    
    func fetch(completion: (_ complete:Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            arrGoal =   try managedContext.fetch(fetchRequest) 
            completion(true)
        } catch {
            debugPrint("Could not Fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexpath:IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(arrGoal[indexpath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint("Object not deleted:\(error.localizedDescription)")
        }
    }
}

