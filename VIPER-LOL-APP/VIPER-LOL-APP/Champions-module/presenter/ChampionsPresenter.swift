//
//  ChampionsPresenter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit
import LeagueAPI

//View -> Presenter
protocol ChampionsWeekPresenterProtocol {
    func viewDidLoad()
}

protocol ChampionsWeekPresenterDelegate: class {
    func showWeekChampions(with champions: ChampionRotations)
}

final class ChampionsPresenter: ChampionsWeekPresenterProtocol {
    
    private weak var delegate: ChampionsWeekPresenterDelegate?
    private var interactor: ChampionsWeekInteractorProtocol
    
    init(delegate: ChampionsWeekPresenterDelegate, interactor: ChampionsWeekInteractorProtocol = ChampionsInteractor()) {
        self.delegate = delegate
        self.interactor = interactor
        self.interactor.setDelegate(delegate: self)
    }
    
    func viewDidLoad() {
        self.loadWeekChampions()
    }
    
    private func fetchPressedFor(championId id: Int) {
        return
    }
    
    private func loadWeekChampions() {
        interactor.fetch()
    }
    
}

extension ChampionsPresenter: ChampionsWeekInteractorDelegate {
    func fetched(champions: ChampionRotations) {
        DispatchQueue.main.async {
            self.delegate?.showWeekChampions(with: champions)
        }
    }
    
    func fetchFailed() {
        return
    }
}
