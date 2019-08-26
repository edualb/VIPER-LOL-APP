//
//  FirstChampionTableViewCell.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 21/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class FirstChampionTableViewCell: UITableViewCell {

    @IBOutlet weak var championImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupChampionCell()
        self.layer.borderWidth = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(with model: ChampionModelView) {
        self.championImg.contentMode = .top
        self.championImg.clipsToBounds = true
        model.imgLoading?.getImage(handler: { (img, msgError) in
            if let img = img {
                DispatchQueue.main.async {
                    self.championImg.image = img.resizeTopAlignedToFill(newWidth: self.championImg.frame.width * 1.1)
                }
            }
        })
    }

}
