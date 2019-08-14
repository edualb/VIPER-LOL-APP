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
protocol ChampionWeekPresenterProtocol {
    func viewDidLoad()
}

protocol ChampionWeekPresenterDelegate: class {
    func showWeekChampions(with champions: [ChampionModelView])
}

final class ChampionPresenter: ChampionWeekPresenterProtocol {
    
    private weak var delegate: ChampionWeekPresenterDelegate?
    private var interactor: ChampionWeekInteractorProtocol
    
    init(delegate: ChampionWeekPresenterDelegate, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
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

extension ChampionPresenter: ChampionWeekInteractorDelegate {
    func fetched(champions: [ChampionEntity]) {
        DispatchQueue.main.async {
            self.delegate?.showWeekChampions(with: ChampionModelViewMapper.convert(from: champions))
        }
    }
    
    func fetchFailed() {
        return
    }
    
    private func convert(from champions: [ChampionEntity]) -> [ChampionModelView] {
        var championsModelView: [ChampionModelView] = []
        champions.forEach { champion in
            championsModelView.append(ChampionModelView(name: champion.name))
        }
        return championsModelView
    }
}

struct ChampionModelViewMapper {
    static func convert(from champions: [ChampionEntity]) -> [ChampionModelView] {
        var championsModelView: [ChampionModelView] = []
        champions.forEach { champion in
            championsModelView.append(ChampionModelView(name: champion.name))
        }
        return championsModelView
    }
}
