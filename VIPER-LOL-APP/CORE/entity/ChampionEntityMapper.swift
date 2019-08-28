//
//  ChampionEntityMapper.swift
//  VIPER-LOL-APP-COLLECTION-VIEW
//
//  Created by eduardo.silva on 28/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import Foundation
import LeagueAPI

struct ChampionEntityMapper {
    static func make(from championDetails: ChampionDetails, imgSkins: [ImageWithUrl]) -> ChampionEntity {
        let champion = ChampionEntity(
            name: championDetails.name,
            title: championDetails.title,
            description: championDetails.presentationText,
            img: championDetails.images?.square,
            imgLoading: championDetails.images?.loading,
            imgSkins: imgSkins)
        return champion
    }
}
