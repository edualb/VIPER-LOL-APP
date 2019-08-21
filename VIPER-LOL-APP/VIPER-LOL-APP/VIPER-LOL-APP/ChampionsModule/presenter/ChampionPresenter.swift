//
//  ChampionsPresenter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit
import LeagueAPI

protocol PresenterProtocol {
    func viewDidLoad()
}

//View -> Presenter
protocol ChampionPresenterProtocol: PresenterProtocol {
    func didSelectRowAt(index: Int)
}

protocol ChampionWeekPresenterDelegate: class {
    func showWeekChampions(with champions: [ChampionModelView])
}

final class ChampionPresenter: ChampionPresenterProtocol {
    
    private weak var delegate: ChampionWeekPresenterDelegate?
    private var router: ChampionsWeekRouterProtocol
    private var interactor: ChampionWeekInteractorProtocol
    private var champions: [ChampionModelView] = []
    
    init(delegate: ChampionWeekPresenterDelegate, router: ChampionsWeekRouterProtocol, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
        self.delegate = delegate
        self.interactor = interactor
        self.router = router
        self.interactor.setDelegate(delegate: self)
    }
    
    func viewDidLoad() {
        self.loadWeekChampions()
    }
    
    func didSelectRowAt(index: Int) {
        let modelView = champions[index]
        self.router.presentChampionDetail(modelView: modelView, interactor: self.interactor)
    }
    
    private func loadWeekChampions() {
        interactor.fetch()
    }
    
}

extension ChampionPresenter: ChampionWeekInteractorDelegate {
    func fetched(champion: ChampionEntity) {
        DispatchQueue.main.async {
            self.champions.append(ChampionModelViewMapper.convert(from: champion))
            self.delegate?.showWeekChampions(with: self.champions)
        }
    }
    
    func fetchFailed() {
        return
    }

}

struct ChampionModelViewMapper {
    static func convert(from champion: ChampionEntity) -> ChampionModelView {
        // var championsModelView: [ChampionModelView] = []
//        champions.forEach { champion in
//            championsModelView.append(ChampionModelView(
//                name: champion.name,
//                description: champion.description,
//                img: champion.img,
//                imgLoading: champion.imgLoading)
//            )
//        }
        return ChampionModelView(name: champion.name,
            description: champion.description,
            img: champion.img,
            imgLoading: champion.imgLoading)
    }
}
