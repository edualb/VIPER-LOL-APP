//
//  ChampionTvViewController.swift
//  VIPER-LOL-APP-TVOS
//
//  Created by eduardo.silva on 29/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionTvViewController: UIViewController {
    
    private var presenter: ChampionPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ChampionTvViewController: ChampionWeekPresenterDelegate {
    func showWeekChampions(with champions: [ChampionModelView]) {
        
    }
    
    func showMsgError(with msg: String) {
        
    }
    
    func setPresenter(presenter: ChampionPresenterProtocol) {
        self.presenter = presenter
    }
}
