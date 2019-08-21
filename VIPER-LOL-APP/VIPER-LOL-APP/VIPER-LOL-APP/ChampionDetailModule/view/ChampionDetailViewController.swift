//
//  ChampionDetailViewController.swift
//  VIPER-LOL-APP
//
//  Created by eduardo.silva on 14/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

final class ChampionDetailViewController: UIViewController {

    private var championsRotation: [ChampionModelView]?
    private var presenter: ChampionDetailPresenter?
    private var modelView: ChampionModelView?
    
    @IBOutlet weak var championDescription: UILabel!
    @IBOutlet weak var championName: UILabel!
    @IBOutlet weak var championImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        modelView?.imgLoading?.getImage(handler: { (img, msgError) in
            if let img = img {
                DispatchQueue.main.async {
                    self.championImg.image = img
                }
            }
        })
        championName.text = modelView?.name
        championDescription.text = modelView?.description
        championImg.layer.insertSublayer( self.includeGradient(imageView: championImg), at: 0)
    }

    @IBAction func backButton(_ sender: Any) {
        presenter?.backToInitial()
    }
}

extension ChampionDetailViewController {
    private func includeGradient(imageView: UIImageView) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.frame
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        gradient.locations = [0.0, 0.6]
        return gradient
    }
    
    func setPresenter(presenter: ChampionDetailPresenter) {
        self.presenter = presenter
    }
    
    func setModelView(modelView: ChampionModelView) {
        self.modelView = modelView
    }
}
