//
//  ChampionCollectionViewCell.swift
//  VIPER-LOL-APP-COLLECTION-VIEW
//
//  Created by eduardo.silva on 22/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var championImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 5
    }
    
    override var isSelected: Bool {
        didSet {
            self.championImg.transform = isSelected ? .init(scaleX: 0.1, y: 0.1) : .identity
        }
    }
    
    func setupCell(with model: ChampionModelView) {
        model.img?.getImage(handler: { (img, _) in
            if let img = img {
                DispatchQueue.main.async {
                    self.championImg.image = img
                }
            }
        })
    }
    
    func didHighlight() {
        self.championImg.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    func didUnhighlight() {
        self.championImg.transform = .identity
    }
}
