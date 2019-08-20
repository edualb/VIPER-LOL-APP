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
    
    private static let league = LeagueAPI(APIToken: "RGAPI-aa2139c4-6771-4786-b8a6-01d7963bff06")
    
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
    
    private static func getChampions(by rotations: ChampionRotations, completion: @escaping ([ChampionEntity]) -> Void) {
        var champions: [ChampionEntity] = []
        let dispatchGroup = DispatchGroup()
        for championId in rotations.rotation {
            dispatchGroup.enter()
            self.getChampion(by: championId, completion: { (champion, errorMsg) in
                if let champion = champion {
                    champion.images?.square.getImage(handler: { (img, msgError) in
                        if let img = img {
                            champion.images?.loading.getImage(handler: { (imgUnique, msgError) in
                                if let imgUnique = imgUnique {
                                    champions.append(ChampionEntityMapper.make(from: champion, imgSquare: img, imgLoading:  imgUnique))
                                }
                                dispatchGroup.leave()
                            })
                        }
                    })
                }
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(champions)
        }
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
}

struct ChampionEntityMapper {
    static func make(from championDetails: ChampionDetails, imgSquare: UIImage, imgLoading: UIImage) -> ChampionEntity {
        let champion = ChampionEntity(
            name: championDetails.name,
            title: championDetails.title,
            description: championDetails.presentationText,
            img: imgSquare,
            imgLoading: imgLoading)
        return champion
    }
}
