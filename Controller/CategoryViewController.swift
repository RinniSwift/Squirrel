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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("adding new link inside category")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "addLinkVC") as! AddLinkViewController
        controller.categoryName = categoryTitle.text
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var titleString: String?
    // MOCK DATA
//    var links = ["first link", "second link", "third", "fourth", "and so on", "first link", "second link", "third", "fourth"]
    // updates variable from when clicked the category button
    var totCatInfo: [[String: Any]]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        categoryTitle.text = titleString
        
        flowLayout()
        print("CategoryViewController totCatInfo: \(totCatInfo)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedLinkData(notification:)),name: NSNotification.Name(rawValue: "linkData"), object: nil)
    }
    
    @objc func receivedLinkData(notification: Notification) {
        totCatInfo?.append(notification.userInfo as! [String : Any])
        collectionView.reloadData()
    }
    
    // MARK: - Function
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width - 40) / 2
        let height = (view.frame.size.height - 20) / 5
        layout.itemSize = CGSize(width: width, height: height)
    }

}



extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totCatInfo!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! CategoriesLinkCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        let title = totCatInfo![indexPath.item]["name"] as! String
        cell.linkTitle.text = title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // PRESENT the LinkViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "cellsLinkController") as! LinkViewController
        controller.linkCellTitleString = totCatInfo![indexPath.item]["name"] as! String
        controller.noteTitle = totCatInfo![indexPath.item]["name"] as! String
        controller.noteLink = totCatInfo![indexPath.item]["url"] as! String
        controller.noteNote = totCatInfo![indexPath.item]["notes"] as! String
        controller.mockImages = [totCatInfo![indexPath.item]["image"]] as! [String]
        self.present(controller, animated: true, completion: nil)
    }
}
