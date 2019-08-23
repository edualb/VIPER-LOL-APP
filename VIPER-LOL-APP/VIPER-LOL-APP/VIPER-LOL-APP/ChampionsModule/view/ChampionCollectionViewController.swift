//
//  ChampionCollectionViewController.swift
//  VIPER-LOL-APP-COLLECTION-VIEW
//
//  Created by eduardo.silva on 22/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var championsRotation: [ChampionModelView]?
    private var presenter: ChampionPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .black
        self.view.beginCenterSpinner(activityIndicator: self.activityIndicator)
        presenter?.viewDidLoad()
    }

}

extension ChampionCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return championsRotation?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "championCollectionCell", for: indexPath) as! ChampionCollectionViewCell
        cell.setupCell(with: self.championsRotation![indexPath.row])
        return cell
    }
    
}

extension ChampionCollectionViewController: ChampionWeekPresenterDelegate {
    func showWeekChampions(with champions: [ChampionModelView]) {
        self.championsRotation = champions
        self.collectionView.reloadData()
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func setPresenter(presenter: ChampionPresenterProtocol) {
        self.presenter = presenter
    }
}