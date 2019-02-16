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
        cardView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60, height: (view.frame.height / 2) + 40)
        cardView.center.x = self.view.center.x
        cardView.center.y = self.view.center.y + 30
        cardView.backgroundColor = .smoothWhite
    }
}

