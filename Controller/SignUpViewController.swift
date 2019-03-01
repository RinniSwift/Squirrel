//
//  SignUpViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/27/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBAction func switchSignInButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
    }
}
