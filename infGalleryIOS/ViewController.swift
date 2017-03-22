//
//  ViewController.swift
//  UICollectionView_p1_Swift
//
//  Created by olxios on 20/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var galleryItems: [GalleryItem] = []
    
    // MARK: -
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGalleryItems()
        collectionView.reloadData()
    }
    
    fileprivate func initGalleryItems() {
        
        var items = [GalleryItem]()
        let inputFile = Bundle.main.path(forResource: "items", ofType: "plist")
        
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        
        for inputItem in inputDataArray as! [Dictionary<String, String>] {
            let galleryItem = GalleryItem(dataDictionary: inputItem)
            items.append(galleryItem)
        }
        
        galleryItems = items
    }
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        
        cell.setGalleryItem(galleryItems[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryItemCommentView", for: indexPath) as! GalleryItemCommentView
        
        commentView.commentLabel.text = "Supplementary view of kind \(kind)"
        
        return commentView
    }
    
    // MARK: -
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // let alert = UIAlertController(title: "didSelectItemAtIndexPath:", message: "Indexpath = \(indexPath)", preferredStyle: .alert)
        
       // let alertAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        //alert.addAction(alertAction)
        
        //self.present(alert, animated: true, completion: nil)

        self.performSegue(withIdentifier: "gogoSegue", sender: self)
    }
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("finish")
//
//    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.y))
    }
    func actionOnFinishedScrolling() {
        print("scrolling is finished")


        let visibleCells = collectionView.visibleCells


        let sorted = visibleCells.sorted(){ $0.center.y < $1.center.y }
        let last = visibleCells.last

        sorted.map{ print(collectionView.indexPath(for: $0))}



        self.collectionView?.scrollToItem(at: collectionView.indexPath(for: sorted.last!)!,
                                          at: .bottom,
                                          animated: true)
        // do what you need
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let picDimensionW = self.view.frame.size.width / 2.0
//
//        return CGSize(width: picDimensionW, height: picDimensionW)

        // subtract section left/ right insets mentioned in xib view

        // flow layout have all the important info like spacing, inset of collection view cell, fetch it to find out the attributes specified in xib file
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }

        let heightAvailbleForAllItems =  (collectionView.frame.height - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom)


        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)

        // Suppose we have to create nColunmns
        // widthForOneItem achieved by sunbtracting item spacing if any

        let widthForOneItem = widthAvailbleForAllItems / 2 - flowLayout.minimumInteritemSpacing

        let heightForOneItem = heightAvailbleForAllItems / 4 - flowLayout.minimumInteritemSpacing



        // here height is mentioned in xib file or storyboard
        return CGSize(width: CGFloat(widthForOneItem), height:  CGFloat(heightForOneItem))
    }
//
//    let flow = UICollectionViewFlowLayout()

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let numberOfItems = collectionView.numberOfItems(inSection: 0)
//        let combinedItemWidth:CGFloat = (CGFloat(numberOfItems) * flow.itemSize.width) + ((CGFloat(numberOfItems) - 1) * flow.minimumInteritemSpacing)
//        let padding = (collectionView.frame.size.width - combinedItemWidth) / 2
//
//        return UIEdgeInsetsMake(0, padding, 0, padding)
//    }


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let leftRightInset = 0
//        return UIEdgeInsetsMake(0, CGFloat(leftRightInset), 0, CGFloat(leftRightInset))
//    }
}

