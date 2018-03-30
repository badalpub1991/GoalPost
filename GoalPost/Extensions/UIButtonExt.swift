//
//  UIButtonExt.swift
//  GoalPost
//
//  Created by badal shah on 02/02/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.8235294118, blue: 0.631372549, alpha: 1)
    }
    
    func setDeselectedColor() {
         self.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8666666667, blue: 0.6862745098, alpha: 1)
    }
}

