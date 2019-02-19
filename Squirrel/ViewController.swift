//
//  ViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/16/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
    }
}

extension ViewController {
    // MARK: - Functions
    func UISetup() {
        // main background view controller
        view.backgroundColor = .mainPurple
        
        // card view
        cardView.layer.cornerRadius = 15
        cardView.center.x = self.view.center.x
        cardView.center.y = self.view.center.y
        cardView.backgroundColor = .smoothWhite
        
        // button
        signUpButton.layer.cornerRadius = 8
    }
}
