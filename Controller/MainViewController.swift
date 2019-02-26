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
    // MOCK DATA
    var sampleSectionTitle: [String] = ["SPD 1.2", "Healthy Recipes", "Sports"]
    var sampleCellItem: [String: [String]] = ["SPD 1.2": ["industry contacts", "something else", "happy class", "something else"], "Healthy Recipes": ["cooking", "chicken pie", "something else"], "Sports": ["soccer", "football"]]
    
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
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = sampleSectionTitle[section]
        return (sampleCellItem[index]?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! LinkCollectionViewCell
        cell.backgroundColor = .white
        
        let index = sampleSectionTitle[indexPath.section]
        let sectItem = sampleCellItem[index]
        cell.cellLinksTitle.text = sectItem![indexPath.item]
        cell.layer.cornerRadius = 8
        return cell
    }
    
    // SECTION HEADER
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sampleSectionTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "categoryTitle", for: indexPath) as! CategoryTitleCollectionReusableView
        header.categoryTitleButton.setTitle(sampleSectionTitle[indexPath.section], for: .normal)
        header.mainVC = self
        return header
    }
}
