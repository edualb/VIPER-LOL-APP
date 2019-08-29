//
//  ChampionsView.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 12/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

final class ChampionViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak var msgError: UILabel!
    
    private var championsRotation: [ChampionModelView]?
    private var presenter: ChampionPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .black
        self.view.beginCenterSpinner(activityIndicator: self.activityIndicator)
        presenter?.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
}

//MARK: - TableView Datasource/Delegate
extension ChampionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsRotation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 300 : 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "firstChampionCell", for: indexPath) as! FirstChampionTableViewCell
            (cell as! FirstChampionTableViewCell).setupCell(with: championsRotation![indexPath.row])
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "championsCell", for: indexPath) as! ChampionTableViewCell
            (cell as! ChampionTableViewCell).setupCell(with: championsRotation![indexPath.row])
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
    func showMsgError(with msg: String) {
        self.tableView.isHidden = true
        self.msgError.text = msg
        self.msgError.isHidden = false
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func showWeekChampions(with champions: [ChampionModelView]) {
        self.championsRotation = champions
        self.tableView.isHidden = false
        self.msgError.isHidden = true
        self.tableView.reloadData()
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func setPresenter(presenter: ChampionPresenterProtocol) {
        self.presenter = presenter
    }
}
