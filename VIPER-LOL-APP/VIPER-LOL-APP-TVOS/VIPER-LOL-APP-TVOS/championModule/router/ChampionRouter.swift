//
//  ChampionRouter.swift
//  VIPER-LOL-APP-TVOS
//
//  Created by eduardo.silva on 20/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

protocol ChampionRouterProtocol {
    func present(at window: UIWindow?)
}

final class ChampionRouter: ChampionRouterProtocol {
    weak var window: UIWindow?
    
    func present(at window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChampionViewController") as! ChampionViewController
        self.window = window
    }
}
