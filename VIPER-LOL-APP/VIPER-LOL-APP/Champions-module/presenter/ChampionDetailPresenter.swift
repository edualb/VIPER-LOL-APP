//
//  ChampionDetailPresenter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 15/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionDetailPresenter: PresenterProtocol {
    
    private weak var delegate: ChampionDetailViewController?
    private var router: ChampionsWeekRouterProtocol?
    private var interactor: ChampionWeekInteractorProtocol
    
    init(delegate: ChampionDetailViewController, router: ChampionsWeekRouterProtocol, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
        self.delegate = delegate
        self.interactor = interactor
        self.router = router
        self.interactor.setDelegate(delegate: self)
    }
    
    func viewDidLoad() {
        
    }
    
}

extension ChampionDetailPresenter: ChampionWeekInteractorDelegate {
    func fetched(champions: [ChampionEntity]) {
        
    }
    
    func fetchFailed() {
        return
    }
    
}
