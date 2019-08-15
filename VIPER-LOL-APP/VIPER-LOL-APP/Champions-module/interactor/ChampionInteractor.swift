//
//  ChampionsInteractor.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit
import LeagueAPI

//Presenter -> Interactor
protocol ChampionWeekInteractorProtocol {
    func fetch()
    func setDelegate(delegate: ChampionWeekInteractorDelegate)
}

//Interactor -> Presenter
protocol ChampionWeekInteractorDelegate: class {
    func fetched(champions: [ChampionEntity])
    func fetchFailed()
}

final class ChampionInteractor: ChampionWeekInteractorProtocol {
    
    let league = LeagueAPI(APIToken: "RGAPI-8c34cb10-03d8-41a8-a118-56c6a4f1f1c4")
    private weak var delegate: ChampionWeekInteractorDelegate?
    
    func fetch() {
        league.riotAPI.getChampionRotation(on: .BR) { (rotations, errorMsg) in
            if let rotations = rotations {
                self.getChampionsEntity(by: rotations, completion: { (championsEntity) in
                    self.delegate?.fetched(champions: championsEntity)
                })
                // self.delegate?.fetched(champions: rotations)
            } else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }

    func setDelegate(delegate: ChampionWeekInteractorDelegate) {
        self.delegate = delegate
    }
    
    private func getChampionsEntity(by rotations: ChampionRotations, completion: @escaping ([ChampionEntity]) -> Void) {
        var champions: [ChampionEntity] = []
        let dispatchGroup = DispatchGroup()
        for championId in rotations.rotation {
            dispatchGroup.enter()
            self.fetch(by: championId, completion: { (champion, errorMsg) in
                if let champion = champion {
                    champions.append(ChampionEntityMapper.make(from: champion))
                }
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(champions)
        }
    }
    
    private func fetch(by id: ChampionId, completion: @escaping (ChampionDetails?, String?) -> Void) {
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
    static func make(from championDetails: ChampionDetails) -> ChampionEntity {
        let championEntity = ChampionEntity(
            name: championDetails.name,
            title: championDetails.title,
            description: championDetails.presentationText,
            img: championDetails.images?.square ?? nil,
            imgUnique: championDetails.images?.loading ?? nil)
        return championEntity
    }
}
