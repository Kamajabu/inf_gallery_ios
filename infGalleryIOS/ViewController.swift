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
    var selectedItem: IndexPath = IndexPath(row: 0, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        initGalleryItems()
    }

    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()

    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated),
                                           name: NSNotification.Name.UIDeviceOrientationDidChange,
                                           object: nil)
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

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell",
                                 for: indexPath) as! GalleryItemCollectionViewCell
        
        cell.setGalleryItem(galleryItems[indexPath.row])
        cell.addHeroId("\(HeroConsts.heroCellIdName)\(indexPath.row)")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath
        self.performSegue(withIdentifier: "fullscreenSegue", sender: self)

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        perform(#selector(self.actionOnFinishedScrolling), with: nil, afterDelay: Double(velocity.y))
    }

    @objc func actionOnFinishedScrolling() {
        let visibleCells = collectionView.visibleCells
        let sorted = visibleCells.sorted(){ $0.center.y < $1.center.y }

        self.collectionView?.scrollToItem(at: collectionView.indexPath(for: sorted.last!)!,
                                          at: .bottom,
                                          animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }

        let heightAvailbleForAllItems =  (collectionView.frame.height -
            flowLayout.sectionInset.top - flowLayout.sectionInset.bottom)

        let widthAvailbleForAllItems =  (collectionView.frame.width -
            flowLayout.sectionInset.left - flowLayout.sectionInset.right)

        let widthForOneItem = widthAvailbleForAllItems / 2 - flowLayout.minimumInteritemSpacing
        let heightForOneItem = heightAvailbleForAllItems / 4 - flowLayout.minimumInteritemSpacing

        return CGSize(width: CGFloat(widthForOneItem), height:  CGFloat(heightForOneItem))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullscreenSegue" {
            let toView = segue.destination as! FullScreenCollectionViewController
            toView.imageIndex = selectedItem
            toView.galleryItems = galleryItems
        }
    }

    @objc func rotated() {
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
}

