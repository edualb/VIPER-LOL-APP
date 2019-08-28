//
//  ChampionOrchestration.swift
//  LeagueAPI-iOS
//
//  Created by eduardo.silva on 19/08/19.
//

import UIKit
import LeagueAPI

protocol ChampionOrchestrationProtocol {
    func getChampions(completion: @escaping (ChampionRotations?, String?) -> Void)
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void)
}

final class ChampionOrchestration: ChampionOrchestrationProtocol {
    
    private let league = LeagueAPI(APIToken: "RGAPI-6abb553d-25ba-4b97-b488-1008cb2bfb4d")
    
    func getChampions(completion: @escaping (ChampionRotations?, String?) -> Void) {
        self.league.riotAPI.getChampionRotation(on: .BR) { (rotations, errorMsg) in
            if let rotations = rotations {
                completion(rotations, nil)
            } else {
                completion(nil, errorMsg ?? "No error description")
            }
        }
    }
    
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void) {
        self.league.getChampionDetails(by: id) { (champion, errorMsg) in
            if let champion = champion {
                self.getChampionSkinImages(by: champion, completion: { (imgSkins) in
                    completion(ChampionEntityMapper.make(from: champion, imgSkins: imgSkins), nil)
                })
            } else {
                completion(nil, errorMsg ?? "No error description")
            }
        }
    }
    
    private func getChampionSkinImages(by championDetails: ChampionDetails, completion: @escaping ([ImageWithUrl]) -> Void) {
        var imgSkins: [ImageWithUrl] = []
        championDetails.skins.forEach({ (skin) in
            imgSkins.append(skin.skinImages.loading)
        })
        completion(imgSkins)
    }
}
