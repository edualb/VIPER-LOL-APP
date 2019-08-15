//
//  ChampionsRouter.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 13/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

// Presenter -> Router
protocol ChampionsWeekRouterProtocol {
    func present(at window: UIWindow?)
    func presentChampionDetail(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol)
}

final class ChampionRouter: ChampionsWeekRouterProtocol {
    
    private var viewController: ChampionViewController?
    
    func present(at window: UIWindow?) {
        let storyboard = self.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionViewController") as! ChampionViewController
        let presenter = ChampionPresenter(delegate: viewController, router: self)
        viewController.presenter = presenter
        self.viewController = viewController
        window?.rootViewController = self.viewController
    }
    
    func presentChampionDetail(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol) {
        let storyboard = self.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionDetailViewController") as! ChampionDetailViewController
        let presenter = ChampionDetailPresenter(delegate: viewController, router: self, interactor: interactor)
        viewController.presenter = presenter
        viewController.modelView = modelView
        self.viewController?.show(viewController, sender: "segueChampion")
    }

    private func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}
