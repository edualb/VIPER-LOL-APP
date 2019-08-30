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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var champions: [ChampionModelView]?
    private var presenter: ChampionDetailPresenter?
    private var modelView: ChampionModelView?
    private var indexImage = 0
    private var focusGuide = UIFocusGuide()
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if self.indexImage == (self.modelView?.imgSkins.count ?? 0) - 1 {
            return [self.backButton]
        }
        return [self.nextButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addLayoutGuide(self.focusGuide)
        self.view.backgroundColor = .black
        self.downloadSkinImage(index: indexImage)
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        if self.indexImage < (self.modelView?.imgSkins.count ?? 1) - 1 {
            self.indexImage += 1
            self.downloadSkinImage(index: self.indexImage)
        }
        self.updateFocus()
    }

    @IBAction func backButton(_ sender: Any) {
        if self.indexImage > 0 {
            self.indexImage -= 1
            self.downloadSkinImage(index: self.indexImage)
        } else if self.indexImage == 0 {
            self.updateFocus()
        }
    }
}

extension ChampionDetailTvViewController {
    
    func setPresenter(presenter: ChampionDetailPresenter) {
        self.presenter = presenter
    }
    
    func setModelView(modelView: ChampionModelView) {
        self.modelView = modelView
    }
    
    private func downloadSkinImage(index: Int) {
        self.modelView?.imgSkins[index].getImage(handler: { (image, _) in
            if let image = image {
                DispatchQueue.main.async {
                    self.imageSkin.image = image
                }
            }
        })
    }
    
    private func updateFocus() {
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
}
