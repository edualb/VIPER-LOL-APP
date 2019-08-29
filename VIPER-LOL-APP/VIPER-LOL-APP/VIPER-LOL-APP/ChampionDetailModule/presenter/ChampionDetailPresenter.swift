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
    
//    iOS
//    private weak var delegate: ChampionDetailViewController?
    
//    tvOS
    private weak var delegate: ChampionDetailTvViewController?
    
    private var router: ChampionsDetailRouterProtocol?
    private var interactor: ChampionWeekInteractorProtocol
    
//    iOS
//    init(delegate: ChampionDetailViewController, router: ChampionsDetailRouterProtocol, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
//        self.delegate = delegate
//        self.interactor = interactor
//        self.router = router
//        self.interactor.setDelegate(delegate: self)
//    }
    
//    tvOS
    init(delegate: ChampionDetailTvViewController, router: ChampionsDetailRouterProtocol, interactor: ChampionWeekInteractorProtocol = ChampionInteractor()) {
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
    func fetchFailed(errorMsg: String) {
        
    }
    
    func fetched(champion: ChampionEntity) {
        
    }
    
}
