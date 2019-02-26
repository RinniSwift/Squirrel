//
//  LinkViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/26/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController {
    
    // MARK: - Variables
    var linkCellTitleString: String?

    // MARK: - Outlets
    @IBOutlet weak var linkCellTitle: UILabel!
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkCellTitle.text = linkCellTitleString
    }

}
