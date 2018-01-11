//
//  LoadingSpinner.swift
//  infGalleryIOS
//
//  Created by Kamil Buczel on 11.01.2018.
//  Copyright © 2018 Kamajabu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.9373, green: 0.9804,
                                                   blue: 0.9882, alpha: 1.0)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }

    class func removeSpinner(spinner :UIView) {
        UIView.animate(withDuration: 0.3, delay: 0.2,
                       options: .curveEaseIn, animations: {
                        spinner.alpha = 0
        }) { _ in
            spinner.removeFromSuperview()
        }
    }
}

