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
    
    private weak var delegate: ChampionWeekInteractorDelegate?
    
    func fetch() {
        ChampionOrchestration.getChampions { (champions) in
            self.delegate?.fetched(champions: champions)
        }
    }

    func setDelegate(delegate: ChampionWeekInteractorDelegate) {
        self.delegate = delegate
    }
    
}
