//
//  CategoryViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/24/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var titleString: String? //{
//        didSet {
//            if let titleString = titleString {
//                categoryTitle.text = titleString
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
    }

}
