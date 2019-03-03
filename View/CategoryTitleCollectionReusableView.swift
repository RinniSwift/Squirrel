//
//  CategoryTitleCollectionReusableView.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/21/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CategoryTitleCollectionReusableView: UICollectionReusableView {
    // MainViewController
    
    // MARK: - Variable
    var mainVC: UIViewController? = nil
    var catInfoForIndex: [String : [[String : Any]]]? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var categoryTitleButton: UIButton!
    
    // MARK: - Actions
    @IBAction func categoryTitleButtonTapped(_ sender: UIButton) {
        
        let categorTitle = categoryTitleButton.titleLabel?.text
        
        // PRESENT CategoryViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // instantiating the *CategoryViewController*
        let controller = storyBoard.instantiateViewController(withIdentifier: "categoryViewID") as! CategoryViewController
        controller.titleString = categorTitle
        controller.totCatInfo = catInfoForIndex![(sender.titleLabel?.text)!]
        mainVC!.present(controller, animated: true, completion: nil)
    }
}
