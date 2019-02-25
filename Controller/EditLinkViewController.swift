//
//  EditLinkViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/25/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class EditLinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
