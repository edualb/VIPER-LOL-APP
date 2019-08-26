//
//  ChampionOrchestration.swift
//  LeagueAPI-iOS
//
//  Created by eduardo.silva on 19/08/19.
//

import UIKit
import LeagueAPI

protocol ChampionOrchestrationProtocol {
    static func getChampions(completion: @escaping (ChampionRotations) -> Void)
    static func getChampion(by id: ChampionId, completion: @escaping (ChampionDetails?, String?) -> Void)
}

final class ChampionOrchestration: ChampionOrchestrationProtocol {
    
    private static let league = LeagueAPI(APIToken: "RGAPI-72904294-92cd-41e5-8c4b-07074ada77b8")
    
    static func getChampions(completion: @escaping (ChampionRotations) -> Void) {
        league.riotAPI.getChampionRotation(on: .BR) { (rotations, errorMsg) in
            if let rotations = rotations {
                completion(rotations)
            } else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    static func getChampion(by id: ChampionId, completion: @escaping (ChampionDetails?, String?) -> Void) {
        self.league.getChampionDetails(by: id) { (champion, errorMsg) in
            if let champion = champion {
                completion(champion, nil)
            } else {
                completion(nil, errorMsg)
            }
        }
    }
}
