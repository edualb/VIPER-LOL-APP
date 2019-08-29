//
//  ChampionsModelView.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 14/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import Foundation
import LeagueAPI

struct ChampionModelView {
    var name: String
    var description: String
    var img: ImageWithUrl?
    var imgLoading: ImageWithUrl?
    var imgSkins: [ImageWithUrl]
}
