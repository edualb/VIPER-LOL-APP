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
    static func present(at window: UIWindow?)
}

final class ChampionsRouter: ChampionsWeekRouterProtocol {
    
    static func present(at window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionsViewController") as! ChampionsViewController
        let presenter = ChampionsPresenter(delegate: viewController)
        viewController.presenter = presenter
        window?.rootViewController = viewController
    }

}
