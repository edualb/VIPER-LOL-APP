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
    func fetched(champion: ChampionEntity)
    func fetchFailed()
}

final class ChampionInteractor: ChampionWeekInteractorProtocol {
    
    private weak var delegate: ChampionWeekInteractorDelegate?
    private var orchestration: ChampionOrchestrationProtocol?
    
    init(orchestration: ChampionOrchestrationProtocol = ChampionOrchestration()) {
        self.orchestration = orchestration
    }
    
    func fetch() {
        self.orchestration?.getChampions { (rotation, errorMsg) in
            if let rotation = rotation {
                self.getChampions(by: rotation, completion: { (champion) in
                    self.delegate?.fetched(champion: champion)
                })
            } else {
                self.delegate?.fetchFailed()
            }
        }
    }

    func setDelegate(delegate: ChampionWeekInteractorDelegate) {
        self.delegate = delegate
    }
    
    private func getChampions(by rotations: ChampionRotations, completion: @escaping (ChampionEntity) -> Void) {
        for championId in rotations.rotation {
            self.orchestration?.getChampion(by: championId, completion: { (champion, _) in
                if let champion = champion {
                    completion(champion)
                } else {
                    self.delegate?.fetchFailed()
                }
            })
        }
    }
    
}
