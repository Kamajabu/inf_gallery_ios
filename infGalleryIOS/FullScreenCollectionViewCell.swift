//
//  CollectionViewCell.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit
import Hero

protocol CollectionViewCellDelegate: class {
    func cellDelegateCloseController(sender: AnyObject)
}

class FullScreenCollectionViewCell: UICollectionViewCell {
    weak var closeDelegate: CollectionViewCellDelegate?
    @IBOutlet weak var itemImage: UIImageView!

    func setGalleryItem(_ item:GalleryItem) {
        itemImage.image = UIImage(named: item.itemImage)
    }

    func addHeroId(_ id: String) {
        itemImage.heroID = id
    }
}

