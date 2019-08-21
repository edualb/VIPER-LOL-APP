//
//  extensions.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 21/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func smokeAnimation() {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        self.layer.transform = rotationTransform
        self.alpha = 0.1
        
        UIView.animate(withDuration: 0.85) {
            self.layer.transform = CATransform3DIdentity
            self.alpha = 1.0
        }
    }
}

extension UIView {
    func beginCenterSpinner(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.white
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopCenterSpinner(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
