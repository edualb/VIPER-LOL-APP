//
//  ChampionTvViewController.swift
//  VIPER-LOL-APP-TVOS
//
//  Created by eduardo.silva on 29/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

final class ChampionTvViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: ChampionPresenterProtocol?
    private var champions: [ChampionModelView]?
    private var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .black
        self.view.backgroundColor = .black
        self.view.beginCenterSpinner(activityIndicator: self.activityIndicator)
        presenter?.viewDidLoad()
    }

}

extension ChampionTvViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "championsCell", for: indexPath) as! ChampionTableViewCell
        cell.setupCell(with: champions![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
    
}

extension ChampionTvViewController: ChampionWeekPresenterDelegate {
    func showWeekChampions(with champions: [ChampionModelView]) {
        self.champions = champions
        self.tableView.reloadData()
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func showMsgError(with msg: String) {
        
    }
    
    func setPresenter(presenter: ChampionPresenterProtocol) {
        self.presenter = presenter
    }
}
