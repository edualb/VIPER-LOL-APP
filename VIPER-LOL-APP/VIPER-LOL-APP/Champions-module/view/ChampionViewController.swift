//
//  ChampionsView.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit
import LeagueAPI

final class ChampionViewController: UITableViewController {
    
    var championsRotation: [ChampionModelView]?
    var presenter: ChampionWeekPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsRotation?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "championsCell")
        let customBackgroundColor = UIView()
        customBackgroundColor.backgroundColor = UIColor.black
        
        cell?.textLabel?.text = championsRotation?[indexPath.row].name
        cell?.textLabel?.textColor = UIColor.white
        cell?.selectedBackgroundView = customBackgroundColor
        cell?.imageView?.image = championsRotation?[indexPath.row].img
        return cell!
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

}

extension ChampionViewController: ChampionWeekPresenterDelegate {
    func showWeekChampions(with champions: [ChampionModelView]) {
        self.championsRotation = champions
        self.tableView.reloadData()
    }
    
}
