//
//  FullscreenImageViewController.swift
//  infGalleryIOS
//
//  Created by Kamil Buczel on 22.03.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import UIKit

class FullscreenImageViewController: UIViewController, UIScrollViewDelegate {


    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var pageControl: UIPageControl!

    @IBOutlet var startButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        //1
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height

        //2
        textView.textAlignment = .center
        textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        textView.textColor = .black
        self.startButton.layer.cornerRadius = 4.0


        for index in 1...12 {
            var imgOne = UIImageView(frame: CGRect(x:CGFloat(index-1)*scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
            imgOne.contentMode = .scaleAspectFill
            imgOne.image = UIImage(named: "pic_" + String(index))
            self.scrollView.addSubview(imgOne)
        }

        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 12, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        }else if Int(currentPage) == 1{
            textView.text = "I write mobile tutorials mainly targeting iOS"
        }else if Int(currentPage) == 2{
            textView.text = "And sometimes I write games tutorials about Unity"
        }else{
            textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.startButton.alpha = 1.0
            })
        }
    }
}

