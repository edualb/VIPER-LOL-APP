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
    func present()
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
    
    private weak var window: UIWindow?
    private var viewController: UIViewController?
    
    func present(at window: UIWindow?) {
        let storyboard = self.getMainStoryboard()
//        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionViewController") as! ChampionViewController
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionCollectionViewController") as! ChampionCollectionViewController
        let presenter = ChampionPresenter(delegate: viewController, router: self)
        viewController.setPresenter(presenter: presenter)
        self.viewController = viewController
        let nav = UINavigationController(rootViewController: viewController)
        window?.rootViewController = nav
        self.window = window
    }
    
    func presentChampionDetail(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol) {
        let router = ChampionDetailRouter(router: self, viewController: self.viewController)
        router.present(modelView: modelView, interactor: interactor)
    }
    
    func present() {
        self.present(at: self.window)
    }

}
