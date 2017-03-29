//
//  CollectionViewCell.swift
//  Example
//
//  Created by Benjamin Emdon on 2016-12-28.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func cellDelegateCloseController(sender: AnyObject)
}
class CollectionViewCell: UICollectionViewCell {

    weak var closeDelegate: CollectionViewCellDelegate?

    @IBOutlet weak var itemImage: UIImageView!

    func setGalleryItem(_ item:GalleryItem) {
        itemImage.image = UIImage(named: item.itemImage)
    }

//    @IBAction func backButtonDidTouch(_ sender: Any) {
//        closeDelegate?.cellDelegateCloseController(sender: self)
//    }

}

