//
//  CollectionViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/19/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        flowLayout()
    }
    
    func flowLayout() {
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = view.frame.size.width / 3
        layout.itemSize = CGSize(width: width, height: width)
    }

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "something", for: indexPath) as! SampleCollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
}
