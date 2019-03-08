//
//  MainViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/21/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var modelData = ModelData()
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var cardItemsMakeSchool: [[String: Any]]? = nil
    var cardItemsFashion: [[String: Any]]? = nil
    var cardItemsCat: [[String: Any]]? = nil
    var categories: [String]?
    var totCatinfo: [String: [[String: Any]]]? = nil
    
    
    func setUpVariables() {
        self.categories = modelData.modelCategoryNames
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        flowLayout()
        print("MainViewController: cardItemsMakeSchool = \(cardItemsMakeSchool)")
        print("MainViewController: cardItemsFashion = \(cardItemsFashion)")
        print("MainViewController categories: \(categories)")
        print("MainViewController totCatInfo = \(totCatinfo)")
    }
    
    // MARK: - Functions
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width - 40) / 2
        let height = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: height)
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
        
        let index = categories![indexPath.section]
        let sectItem = totCatinfo![index]
        cell.cellLinksTitle.text = sectItem![indexPath.item]["name"] as! String
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
        let card = totCatinfo![stringCat]![row]
        let url = card["url"] as! String
        
        
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
}
