//
//  ChampionDetailTvViewController.swift
//  VIPER-LOL-APP-TVOS
//
//  Created by eduardo.silva on 29/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import UIKit

class ChampionDetailTvViewController: UIViewController {

    @IBOutlet weak var imageSkin: UIImageView!
    
    private var champions: [ChampionModelView]?
    private var presenter: ChampionDetailPresenter?
    private var modelView: ChampionModelView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.modelView?.imgSkins[0].getImage(handler: { (image, _) in
            if let image = image {
                DispatchQueue.main.async {
                    self.imageSkin.image = image
                }
            }
        })
        // Do any additional setup after loading the view.
    }

}

extension ChampionDetailTvViewController {
    
    func setPresenter(presenter: ChampionDetailPresenter) {
        self.presenter = presenter
    }
    
    func setModelView(modelView: ChampionModelView) {
        self.modelView = modelView
    }
}
