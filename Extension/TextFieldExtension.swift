//
//  textFieldExtension.swift
//  Squirrel
//
//  Created by Rinni Swift on 4/16/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func redOutline() {
        self.layer.cornerRadius = 5.5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            self.layer.borderWidth = 0
        })
    }
    
}
