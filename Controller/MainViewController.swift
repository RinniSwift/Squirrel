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
    
    // MARK: - Variables
    var sampleSectionTitle: [String] = ["SPD 1.2", "Healthy Recipes", "Sports"]
    var sampleCellItem: [String: [String]] = ["SPD 1.2": ["industry contacts", "something else", "happy class", "something else"],
                                              "Healthy Recipes": ["cooking", "chicken pie", "apple moringa", "something else"],
                                              "Sports": ["soccer", "football", "PE", "something else"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        flowLayout()
    }
    
    // MARK: - Functions
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width - 40) / 2
        let height = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    func shadow(cell: UIView) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = .zero
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 10
        cell.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! LinkCollectionViewCell
        cell.backgroundColor = .white
        
        let index = sampleSectionTitle[indexPath.section]
        let sect = sampleCellItem[index]
        print(sect)
        cell.cellLinksTitle.text = sect![indexPath.item]
        cell.layer.cornerRadius = 8
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    // SECTION HEADER
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sampleSectionTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "categoryTitle", for: indexPath) as! CategoryTitleCollectionReusableView
        header.categoryTitle.text = sampleSectionTitle[indexPath.section]
        return header
    }
    
}
