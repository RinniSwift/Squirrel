//
//  CollectionViewCell.swift
//  Squirrel
//
//  Created by Rinni Swift on 3/2/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // LinkViewController
    
    // MARK: - Variables
    var imageInCellVar: UIImage? {
        didSet {
            // Set in LinkViewController
            imageInCell.image = imageInCellVar
            
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
}
