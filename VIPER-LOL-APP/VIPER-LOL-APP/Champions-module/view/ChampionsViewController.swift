//
//  ChampionsView.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit
import LeagueAPI

final class ChampionsViewController: UITableViewController {
    
    var championsRotation: ChampionRotations?
    var presenter: ChampionsWeekPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsRotation?.newPlayerRotation.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "championsCell")
        cell?.textLabel?.text = String(describing: championsRotation?.newPlayerRotation[indexPath.row].value ?? 0)
        return cell!
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    struct Pessoa {
        var name: String = ""
    }
    class Pessoa2 {
        var name: String = ""
        
        init(name: String) {
            self.name = name
        }
    }

}

extension ChampionsViewController: ChampionsWeekPresenterDelegate {
    func showWeekChampions(with champions: ChampionRotations) {
        self.championsRotation = champions
        self.tableView.reloadData()
    }
    
}
