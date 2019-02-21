//
//  CollectionViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/19/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var sampleSectionTitle: [String] = ["SPD 1.2", "Healthy Recipes", "Sports"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        flowLayout()
    }
    
    func flowLayout() {
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width - 40) / 2
        let height = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: height)
    }

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "something", for: indexPath) as! SampleCollectionViewCell
        cell.backgroundColor = .mainPurple
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    // SECTION HEADER
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sampleSectionTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "something", for: indexPath) as! SampleCollectionReusableView
        header.categoryTitle.text = sampleSectionTitle[indexPath.section]
        return header
    }
}
