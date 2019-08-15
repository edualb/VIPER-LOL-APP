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
    func presentChampionDetail(modelView: ChampionModelView)
}

protocol ChampionWeekPresenterDelegate: class {
    func showWeekChampions(with champions: [ChampionModelView])
}

final class ChampionPresenter: ChampionPresenterProtocol {
    
    private weak var delegate: ChampionWeekPresenterDelegate?
    private var router: ChampionsWeekRouterProtocol?
    private var interactor: ChampionWeekInteractorProtocol
    
    init(delegate: ChampionWeekPresenterDelegate, router: ChampionsWeekRouterProtocol, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
        self.delegate = delegate
        self.interactor = interactor
        self.router = router
        self.interactor.setDelegate(delegate: self)
    }
    
    func viewDidLoad() {
        self.loadWeekChampions()
    }
    
    func presentChampionDetail(modelView: ChampionModelView) {
        self.router?.presentChampionDetail(modelView: modelView, interactor: self.interactor)
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
            ChampionModelViewMapper.convert(from: champions, completion: { (champions) in
                self.delegate?.showWeekChampions(with: champions)
            })
        }
    }
    
    func fetchFailed() {
        return
    }

}

struct ChampionModelViewMapper {
    static func convert(from champions: [ChampionEntity], completion: @escaping ([ChampionModelView]) -> Void ) {
        var championsModelView: [ChampionModelView] = []
        let dispatchGroup = DispatchGroup()
        champions.forEach { champion in
            dispatchGroup.enter()
            champion.img?.getImage(handler: { (img, msgError) in
                if let img = img {
                    champion.imgUnique?.getImage(handler: { (imgUnique, msgError) in
                        if let imgUnique = imgUnique {
                            championsModelView.append(ChampionModelView(
                                name: champion.name,
                                description: champion.description,
                                img: img,
                                imgUnique: imgUnique))
                        }
                        dispatchGroup.leave()
                    })
                }
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(championsModelView)
        }
    }
}
