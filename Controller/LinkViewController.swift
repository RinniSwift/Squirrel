//
//  LinkViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/26/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController {
    
    
    
    // MARK: - Variables
    var linkCellTitleString: String?
    var noteTitle: String?
    var noteLink: String?
    var noteNote: String?

    // MARK: - Outlets
    @IBOutlet weak var linkCellTitle: UILabel!  // nav bar
    @IBOutlet weak var linkTitle: UILabel!      // body
    @IBOutlet weak var linksLink: UILabel!      // body
    @IBOutlet weak var linksNote: UILabel!      // body
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkCellTitle.text = linkCellTitleString
        linkTitle.text = "Title: \(noteTitle!)"
        linksLink.text = "Link: \(noteLink!)"
        linksNote.text = "Note: \(noteNote!)"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension LinkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell
//        cell?.imageInCell.image = UIImage(named: "mockImage")
        cell?.imageInCell.backgroundColor = .blue
        return cell!
    }
    
    
    // SECTION
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "imageHeader", for: indexPath) as! ImageCollectionReusableView
        return header
    }
}


extension LinkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 1
        let height = (collectionView.bounds.height / 2) + 30
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
}
