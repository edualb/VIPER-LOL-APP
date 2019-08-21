//
//  ChampionsView.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit
import LeagueAPI

final class ChampionViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var championsRotation: [ChampionModelView]?
    private var presenter: ChampionPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .black
        //self.tableView.rowHeight = 100.0
        self.view.beginCenterSpinner(activityIndicator: self.activityIndicator)
        presenter?.viewDidLoad()
    }
}

//MARK: - TableView Datasource/Delegate

extension ChampionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsRotation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "firstChampionCell", for: indexPath) as! FirstChampionTableViewCell
            (cell as! FirstChampionTableViewCell).setupCell(with: championsRotation![indexPath.row])
            self.tableView.rowHeight = 300
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "championsCell", for: indexPath) as! ChampionTableViewCell
            (cell as! ChampionTableViewCell).setupCell(with: championsRotation![indexPath.row])
            self.tableView.rowHeight = 100
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.smokeAnimation()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
}

extension ChampionViewController: ChampionWeekPresenterDelegate {
    func showWeekChampions(with champions: [ChampionModelView]) {
        self.championsRotation = champions
        self.tableView.reloadData()
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func setPresenter(presenter: ChampionPresenterProtocol) {
        self.presenter = presenter
    }
}
