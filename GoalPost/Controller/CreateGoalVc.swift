//
//  CreateGoalVc.swift
//  GoalPost
//
//  Created by badal shah on 02/02/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

import UIKit

class CreateGoalVc: UIViewController, UITextViewDelegate {
    
    //Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnShortTerm: UIButton!
    @IBOutlet weak var btnLongTerm: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    //Variables
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.bindToKeybord()
        btnShortTerm.setSelectedColor()
        btnLongTerm.setDeselectedColor()
        textView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }

    @IBAction func longTermAndShortTermButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            goalType = .shortTerm
            btnShortTerm.setSelectedColor()
            btnLongTerm.setDeselectedColor()
        } else {
            goalType = .longTerm
            btnShortTerm.setDeselectedColor()
            btnLongTerm.setSelectedColor()
            
        }
    }
    
    @IBAction func backButtonCliked(_ sender: UIButton) {
        dismissDetail()
    }
    
    @IBAction func nextButtonWasPressed(_ sender: UIButton) {
        if textView.text != "" && textView.text != "what is your goal?" {
            guard let finishGoalsVc = storyboard?.instantiateViewController(withIdentifier: "FinishGoalsVC") as? FinishGoalsVC else {return}
            finishGoalsVc.initData(description: textView.text, type: goalType)
            //presentDetail(finishGoalsVc)
            presentingViewController?.presentSecondaryDetail(finishGoalsVc)
        }
       
        
    }
    
}
