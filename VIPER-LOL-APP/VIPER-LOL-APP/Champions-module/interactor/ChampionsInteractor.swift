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
protocol ChampionsWeekInteractorProtocol {
    func fetch(by id: Int)
    func fetch()
    func setDelegate(delegate: ChampionsWeekInteractorDelegate)
}

//Interactor -> Presenter
protocol ChampionsWeekInteractorDelegate: class {
    func fetched(champions: ChampionRotations)
    func fetchFailed()
}

final class ChampionsInteractor: ChampionsWeekInteractorProtocol {
    
    let league = LeagueAPI(APIToken: "RGAPI-5c79ed4d-56c2-4a58-9545-d0217359756b")
    private weak var delegate: ChampionsWeekInteractorDelegate?
    
    func fetch(by id: Int) {
        return
    }
    
    func fetch() {
        league.riotAPI.getChampionRotation(on: .BR) { (rotations, errorMsg) in
            if let rotations = rotations {
                self.delegate?.fetched(champions: rotations)
            } else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }

    func setDelegate(delegate: ChampionsWeekInteractorDelegate) {
        self.delegate = delegate
    }
}
