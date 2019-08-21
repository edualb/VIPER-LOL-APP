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

extension UIImageView {
    func includeGradient(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        gradient.locations = [0.0, 0.6]
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UITableViewCell {
    func setupChampionCell() {
        self.contentView.backgroundColor = UIColor(white: 0.0, alpha: 0.9)
    }
}

extension UIImage {
    
    // Link of solution -  https://stackoverflow.com/questions/47884519/is-it-possible-to-use-the-aspect-fill-content-mode-combined-with-the-top-content
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
        let newHeight = size.height
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
