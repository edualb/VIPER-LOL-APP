//
//  ChampionOrchestration.swift
//  LeagueAPI-iOS
//
//  Created by eduardo.silva on 19/08/19.
//

import UIKit
import LeagueAPI

protocol ChampionOrchestrationProtocol {
    static func getChampions(completion: @escaping ([ChampionEntity]) -> Void)
}

class ChampionOrchestration: ChampionOrchestrationProtocol {
    
    private static let league = LeagueAPI(APIToken: "RGAPI-94c50247-7319-4f4f-85ba-6529c935168b")
    
    static func getChampions(completion: @escaping ([ChampionEntity]) -> Void) {
        league.riotAPI.getChampionRotation(on: .BR) { (rotations, errorMsg) in
            if let rotations = rotations {
                self.getChampions(by: rotations, completion: { (champions) in
                    completion(champions)
                })
            } else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    //TODO: remove dispatchGroup
    private static func getChampions(by rotations: ChampionRotations, completion: @escaping ([ChampionEntity]) -> Void) {
        var champions: [ChampionEntity] = []
        let dispatchGroup = DispatchGroup()
        for championId in rotations.rotation {
            dispatchGroup.enter()
            self.getChampion(by: championId, completion: { (champion, errorMsg) in
                if let champion = champion {
                    self.getChampionSkinImages(by: champion, completion: { (imgSkins) in
                        champions.append(ChampionEntityMapper.make(from: champion, imgSkins: imgSkins))
                        dispatchGroup.leave()
                    })
                }
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(champions)
        }
    }
    
    private static func getChampionSkinImages(by championDetails: ChampionDetails, completion: @escaping ([ImageWithUrl]) -> Void) {
        var imgSkins: [ImageWithUrl] = []
        championDetails.skins.forEach({ (skin) in
            imgSkins.append(skin.skinImages.loading)
        })
        completion(imgSkins)
    }
    
    private static func getChampion(by id: ChampionId, completion: @escaping (ChampionDetails?, String?) -> Void) {
        self.league.getChampionDetails(by: id) { (champion, errorMsg) in
            if let champion = champion {
                completion(champion, nil)
            } else {
                completion(nil, errorMsg)
            }
        }
    }

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
}
