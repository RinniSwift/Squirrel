//
//  MainViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/21/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var categories: [String]?
    var totCatinfo: [String: [CardInfo]]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        flowLayout()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        longPressGesture.delegate = self
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = categories![section]
        return (totCatinfo![index]?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! LinkCollectionViewCell
        cell.backgroundColor = .white
        
        let indexString = categories![indexPath.section]
        let sectItem = totCatinfo![indexString]
        cell.cellLinksTitle.text = sectItem![indexPath.item].name
        cell.layer.cornerRadius = 8
        return cell
    }
    
    // SECTION HEADER
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let attributedString = NSAttributedString(
            string: NSLocalizedString(categories![indexPath.section], comment: ""), attributes:  [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 17.0)!, NSAttributedString.Key.foregroundColor : UIColor.blueText, NSAttributedString.Key.underlineStyle: 1.0]
        )
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "categoryTitle", for: indexPath) as! CategoryTitleCollectionReusableView
        header.categoryTitleButton.setAttributedTitle(attributedString, for: .normal)
        header.mainVC = self
        header.catInfoForIndex = totCatinfo
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let section = indexPath.section
        let row = indexPath.row
        let stringCat = categories![section]
        let totCat = totCatinfo![stringCat]![row]
        let url = totCat.url
        
        
        guard let urll = URL(string: url) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(urll) {
            UIApplication.shared.open(urll, options: [:])
        } else {
            alertMessageNoLink()
            return
        }
    }
    
}


extension MainViewController {
    
    func alertMessageNoLink() {
        let alert = UIAlertController(title: "No Link", message: "Wrong link or no link stored.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width - 40) / 2
        let height = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state != .ended {
            return
        }
        let point = gesture.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        if let index = indexPath {
            let cell = self.collectionView.cellForItem(at: index) as! LinkCollectionViewCell
            let nameOfLink = cell.cellLinksTitle.text
            let categoryTitle = categories![(indexPath?.section)!]
            let cardsInCategory = totCatinfo![categoryTitle]!
            let cardItemTapped = cardsInCategory[index.item]
            showActionSheet(item: cardItemTapped, index: (indexPath?.item)!)
            
        } else {
            print("could not find index path")
        }
    }
    
    func showActionSheet(item: CardInfo, index: Int) {
        let alert = UIAlertController(title: "Action", message: "Please select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { (_) in
            print("user selected open link")
            }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("deleted: \(item.name)")
            
            let category = item.category
            
            self.totCatinfo![category]?.remove(at: index) // remove from totCatInfo array at index
            self.collectionView.reloadData()
            // TODO: send a 'DELETE' request in that category, reload the collectionview in main queue.
            
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
