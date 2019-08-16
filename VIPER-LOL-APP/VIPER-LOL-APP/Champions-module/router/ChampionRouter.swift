//
//  ChampionsRouter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 13/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

// Presenter -> Router
protocol ChampionsWeekRouterProtocol: RouterProtocol {
    func present(at window: UIWindow?)
    func presentChampionDetail(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol)
}

protocol RouterProtocol {
    func getMainStoryboard() -> UIStoryboard
}

extension RouterProtocol {
    func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

class ChampionRouter: ChampionsWeekRouterProtocol {
    
    private var window: UIWindow?
    
    func present(at window: UIWindow?) {
        let storyboard = self.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionViewController") as! ChampionViewController
        let presenter = ChampionPresenter(delegate: viewController, router: self)
        viewController.presenter = presenter
        window?.rootViewController = viewController
        self.window = window
    }
    
    func presentChampionDetail(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol) {
        let router = ChampionDetailRouter(router: self, window: self.window)
        router.present(modelView: modelView, interactor: interactor)
    }

}
