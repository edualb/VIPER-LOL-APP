//
//  ChampionsProtocols.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import Foundation
import LeagueAPI
import UIKit

//Presenter -> Interactor
protocol ChampionsWeekInteractorProtocol {
    var delegate: ChampionsWeekInteractorDelegate? {get set}
    
    func fetch(by id: Int)
    func fetch()
}

