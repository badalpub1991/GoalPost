//
//  UIViewExt.swift
//  GoalPost
//
//  Created by badal shah on 02/02/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func bindToKeybord() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChnage(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
   @objc func keyboardWillChnage(_ notification:Notification) {
    let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
    let startingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let deltaY = endingFrame.origin.y - startingFrame.origin.y
    UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions.init(rawValue: curve), animations: {
        self.frame.origin.y += deltaY
    }, completion: nil)
    }
}
