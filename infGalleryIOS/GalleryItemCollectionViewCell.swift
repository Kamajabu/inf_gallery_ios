//
//  GalleryItemCollectionViewCell.swift
//  UICollectionView_p1_Swift
//
//  Created by olxios on 20/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

import UIKit
import Hero

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    
    func setGalleryItem(_ item:GalleryItem) {
        itemImageView.image = UIImage(named: item.itemImage)
    }

    func addHeroId(_ id: String) {
        itemImageView.heroID = id
    }
}
