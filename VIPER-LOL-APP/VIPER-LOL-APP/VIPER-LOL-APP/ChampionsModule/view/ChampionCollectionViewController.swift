//
//  ChampionCollectionViewController.swift
//  VIPER-LOL-APP-COLLECTION-VIEW
//
//  Created by eduardo.silva on 22/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionCollectionViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    @IBOutlet weak var msgError: UILabel!
    
    private var championsRotation: [ChampionModelView]?
    private var presenter: ChampionPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.backgroundColor = UIColor.black
        self.collectionView.backgroundColor = .black
        self.view.beginCenterSpinner(activityIndicator: self.activityIndicator)
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.tintColor = .white
    }

}

extension ChampionCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return championsRotation?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "championCollectionCell", for: indexPath) as! ChampionCollectionViewCell
        cell.setupCell(with: self.championsRotation![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInset = UIEdgeInsets()
        edgeInset.top = 25
        edgeInset.bottom = 25
        edgeInset.left = 10
        edgeInset.right = 10
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ChampionCollectionViewCell {
                cell.didHighlight()
                self.presenter?.didSelectRowAt(index: indexPath.row)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ChampionCollectionViewCell {
                cell.didHighlight()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ChampionCollectionViewCell {
                cell.didUnhighlight()
            }
        }
    }
    
}

extension ChampionCollectionViewController: ChampionWeekPresenterDelegate {
    func showMsgError(with msg: String) {
        self.collectionView.isHidden = true
        self.msgError.text = msg
        self.msgError.isHidden = false
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func showWeekChampions(with champions: [ChampionModelView]) {
        self.championsRotation = champions
        self.collectionView.isHidden = false
        self.msgError.isHidden = true
        self.collectionView.reloadData()
        self.view.stopCenterSpinner(activityIndicator: self.activityIndicator)
    }
    
    func setPresenter(presenter: ChampionPresenterProtocol) {
        self.presenter = presenter
    }
}
