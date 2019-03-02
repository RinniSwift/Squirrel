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
    var noteTitle: String?
    var noteLink: String?
    var noteNote: String?

    // MARK: - Outlets
    @IBOutlet weak var linkCellTitle: UILabel!  // nav bar
    @IBOutlet weak var linkTitle: UILabel!      // body
    @IBOutlet weak var linksLink: UILabel!      // body
    @IBOutlet weak var linksNote: UILabel!      // body
    
    
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkCellTitle.text = linkCellTitleString
        linkTitle.text = "Title: \(noteTitle)"
        linksLink.text = "Link: \(noteLink)"
        noteNote = "Note: \(noteNote)"
    }

}
