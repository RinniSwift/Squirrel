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
    
    func setShadow(cell: UIView) {
        cell.layer.shadowOffset = CGSize(width: 0, height: 10)
        cell.layer.shadowRadius = 20
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! LinkCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        return cell
    }
    
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
