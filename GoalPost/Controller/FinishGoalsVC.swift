//
//  FinishGoalsVC.swift
//  GoalPost
//
//  Created by badal shah on 02/02/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalsVC: UIViewController {
    //Outlets
    @IBOutlet weak var txtPoints: UITextField!
    @IBOutlet weak var btnCreateGoal: UIButton!
    //Variable
    var goalDescription: String!
    var type: GoalType!
    
    
    func initData(description:String , type:GoalType) {
        self.goalDescription = description
        self.type = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     btnCreateGoal.bindToKeybord()
        // Do any additional setup after loading the view.
    }


    @IBAction func createGoalButtonWasPressed(_ sender: UIButton) {
        //Pass Data into coredata Goal Model
        if txtPoints.text != nil {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
       
    }
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let manageContex = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: manageContex)
        goal.goalDescription = goalDescription
        goal.goalType = type.rawValue
        goal.goalComplitionValue = Int32(txtPoints.text!)!
        goal.goalProgress = Int32(0)
        do {
         try  manageContex.save()
            completion(true)
        } catch {
            debugPrint("could not save \(error.localizedDescription)")
            completion(false)
        }
    }
}
