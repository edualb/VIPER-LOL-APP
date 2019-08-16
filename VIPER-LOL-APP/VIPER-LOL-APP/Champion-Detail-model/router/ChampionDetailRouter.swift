//
//  ChampionDetailRouter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 16/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

// Presenter -> Router
protocol ChampionsDetailRouterProtocol: RouterProtocol {
    func present(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol)
    func presentChampion()
}

final class ChampionDetailRouter: ChampionsDetailRouterProtocol {
    
    private weak var window: UIWindow?
    private var router: ChampionsWeekRouterProtocol?
    
    init(router: ChampionsWeekRouterProtocol, window: UIWindow?) {
        self.router = router
        self.window = window
    }
    
    func presentChampion() {
        router?.present(at: self.window)
    }
    
    func present(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol) {
        let storyboard = self.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionDetailViewController") as! ChampionDetailViewController
        let presenter = ChampionDetailPresenter(delegate: viewController, router: self, interactor: interactor)
        viewController.presenter = presenter
        viewController.modelView = modelView
        self.window?.rootViewController?.show(viewController, sender: "segueChampion")
    }
}
