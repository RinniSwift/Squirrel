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
    
    // MOCK DATA
    var mockImages: [String] = ["https://www.hadzup.com/images/dribbble.png", "https://static1.squarespace.com/static/550a10cbe4b03c7ec206488b/55165997e4b0617803522a94/55165997e4b0617803522aea/1427529866738/iphone-6-6-plus-space-and-earth-blue-black-wallpaper-background-165.jpg?format=500w", "https://scstylecaster.files.wordpress.com/2014/03/8058cb6fd5c1f5c20bb4d30a2e44bf7a.jpeg", "https://www.google.com/search?biw=1680&bih=971&tbm=isch&sa=1&ei=llN7XK_tHpG5ggeGoYjIAw&q=spd&oq=spd&gs_l=img.3..0l10.12897059.12897251..12897576...0.0..0.63.170.3......1....1..gws-wiz-img.......35i39j0i67.FwIc8FtV6ew#imgrc=Dnea2HioC0PmRM:"]

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
    
    func stringToImage(string: String) -> UIImage {
        let url = URL(string: string)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        
        if image == nil {
            return UIImage(named: "error-image-generic")!
        } else {
            return image!
        }
    }
}


extension LinkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let imageStringUrl = mockImages[indexPath.item]
        
        DispatchQueue.main.async {
            cell.imageInCell.image = self.stringToImage(string: imageStringUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = CGPoint(x: cell.contentView.frame.height / 2, y: cell.contentView.frame.width / 2)
        activityView.startAnimating()
        cell.addSubview(activityView)
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
