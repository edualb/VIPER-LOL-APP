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
    
    private weak var viewController: UIViewController?
    private var router: ChampionsWeekRouterProtocol?
    
    init(router: ChampionsWeekRouterProtocol, viewController: UIViewController?) {
        self.router = router
        self.viewController = viewController
    }
    
    func presentChampion() {
        router?.present()
    }
    
    func present(modelView: ChampionModelView, interactor: ChampionWeekInteractorProtocol) {
        let storyboard = self.getMainStoryboard()
//        iOS
//        let detailViewController = storyboard.instantiateViewController(withIdentifier: "ChampionDetailViewController") as! ChampionDetailViewController
        
//        tvOS
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "ChampionDetailTvViewController") as! ChampionDetailTvViewController
        let presenter = ChampionDetailPresenter(delegate: detailViewController, router: self, interactor: interactor)
        detailViewController.setPresenter(presenter: presenter)
        detailViewController.setModelView(modelView: modelView)
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
