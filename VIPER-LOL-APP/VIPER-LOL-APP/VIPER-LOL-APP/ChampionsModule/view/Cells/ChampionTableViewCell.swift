//
//  ChampionTableViewCell.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 20/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

final class ChampionTableViewCell: UITableViewCell {

    @IBOutlet weak private var championImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(white: 0.0, alpha: 0.85)
        self.layer.borderWidth = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBorder()
        self.contentView.backgroundColor = self.isSelected || self.isHighlighted ? .black : UIColor(white: 0.0, alpha: 0.9)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = .black
        }
    }
    
    func setupCell(with model: ChampionModelView) {
        self.championImageView.image = model.img
        self.nameLabel.text = model.name
        self.nameLabel.textColor = .white
    }
    
    private func setupBorder() {
        championImageView.layer.cornerRadius = championImageView.frame.height / 2
        championImageView.layer.masksToBounds = true
    }

}
