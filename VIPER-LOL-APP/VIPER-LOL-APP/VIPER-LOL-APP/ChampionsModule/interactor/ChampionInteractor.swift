//
//  ChampionsInteractor.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

//Presenter -> Interactor
protocol ChampionWeekInteractorProtocol {
    func fetch()
    func setDelegate(delegate: ChampionWeekInteractorDelegate)
}

//Interactor -> Presenter
protocol ChampionWeekInteractorDelegate: class {
    func fetched(champion: ChampionEntity)
    func fetchFailed(errorMsg: String)
}

final class ChampionInteractor: ChampionWeekInteractorProtocol {
    
    private weak var delegate: ChampionWeekInteractorDelegate?
    private var orchestration: ChampionOrchestrationProtocol?
    
    init(orchestration: ChampionOrchestrationProtocol = ChampionOrchestration()) {
        self.orchestration = orchestration
    }
    
    func fetch() {
        self.orchestration?.getChampion { (champion, errorMsg) in
            if let champion = champion {
                self.delegate?.fetched(champion: champion)
            } else {
                self.delegate?.fetchFailed(errorMsg: errorMsg!)
            }
        }
    }

    func setDelegate(delegate: ChampionWeekInteractorDelegate) {
        self.delegate = delegate
    }
}
