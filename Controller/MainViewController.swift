//
//  MainViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/21/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var cardItemsMakeSchool: [[String: Any]]? = nil
    var cardItemsFashion: [[String: Any]]? = nil
    var categories: [String]? = nil
    var totCatinfo: [String: [[String: Any]]]? = nil
    
    // MARK: - Variables
//    var sampleSectionTitle: [String] = ["SPD 1.2", "Healthy Recipes", "Sports"]
//    var sampleCellItem: [String: [String]] = ["SPD 1.2": ["industry contacts", "something else", "happy class", "something else"], "Healthy Recipes": ["cooking", "chicken pie", "something else"], "Sports": ["soccer", "football"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        flowLayout()
        print("MainViewController: cardItem MS = \(cardItemsMakeSchool)")
        print("MainViewController: cardItems Fashion = \(cardItemsFashion)")
        print("MainViewController categories: \(categories)")
        print("MainViewController total Categories = \(totCatinfo)")
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
}
