//
//  ChampionCollectionViewCell.swift
//  VIPER-LOL-APP-COLLECTION-VIEW
//
//  Created by eduardo.silva on 22/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var championImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
}
