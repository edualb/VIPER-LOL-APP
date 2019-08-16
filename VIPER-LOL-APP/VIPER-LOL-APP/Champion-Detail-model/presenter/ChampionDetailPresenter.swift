//
//  ChampionDetailPresenter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 15/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

protocol ChampionDetailPresenterProtocol: PresenterProtocol {
    func backToInitial()
}

final class ChampionDetailPresenter: ChampionDetailPresenterProtocol {
    
    private weak var delegate: ChampionDetailViewController?
    private var router: ChampionsDetailRouterProtocol?
    private var interactor: ChampionWeekInteractorProtocol
    
    init(delegate: ChampionDetailViewController, router: ChampionsDetailRouterProtocol, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
        self.delegate = delegate
        self.interactor = interactor
        self.router = router
        self.interactor.setDelegate(delegate: self)
    }
    
    func viewDidLoad() {
        
    }
    
    func backToInitial() {
        router?.presentChampion()
    }
    
}

extension ChampionDetailPresenter: ChampionWeekInteractorDelegate {
    func fetched(champions: [ChampionEntity]) {
        
    }
    
    func fetchFailed() {
        return
    }
    
}
