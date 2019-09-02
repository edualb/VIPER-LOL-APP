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
    @IBOutlet weak var moreInfoButton: UIButton!
    
    private var champions: [ChampionModelView]?
    private var presenter: ChampionDetailPresenter?
    private var modelView: ChampionModelView?
    private var indexImage = 0
    private var focusGuide1 = UIFocusGuide()
    private var focusGuide2 = UIFocusGuide()
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if self.indexImage == (self.modelView?.imgSkins.count ?? 0) - 1 {
            return [self.backButton]
        }
        return [self.nextButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.downloadSkinImage(index: indexImage)
        
        self.view.addLayoutGuide(self.focusGuide1)
        self.view.addLayoutGuide(self.focusGuide2)
        self.configFocusGuide1()
        self.configFocusGuide2()
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        guard let nextFocusedView = context.nextFocusedView else { return }
        
        switch nextFocusedView {
            case self.nextButton:
                focusGuide1.preferredFocusEnvironments = [self.moreInfoButton]
            case self.moreInfoButton:
                if context.previouslyFocusedView == self.nextButton {
                    focusGuide1.preferredFocusEnvironments = [self.backButton]
                } else {
                    focusGuide1.preferredFocusEnvironments = [self.nextButton]
                }
                focusGuide2.preferredFocusEnvironments = [self.backButton]
            case self.backButton:
                focusGuide1.preferredFocusEnvironments = [self.moreInfoButton]
                focusGuide2.preferredFocusEnvironments = [self.moreInfoButton]
            default:
                self.updateFocus()
                focusGuide1.preferredFocusEnvironments = self.preferredFocusEnvironments
        }
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
    
    private func configFocusGuide1() {
        self.focusGuide1.widthAnchor.constraint(equalTo: self.moreInfoButton.widthAnchor).isActive = true
        self.focusGuide1.rightAnchor.constraint(equalTo: self.moreInfoButton.rightAnchor).isActive = true
        self.focusGuide1.heightAnchor.constraint(equalTo: self.nextButton.heightAnchor).isActive = true
        self.focusGuide1.bottomAnchor.constraint(equalTo: self.nextButton.bottomAnchor).isActive = true
        self.focusGuide1.preferredFocusEnvironments = self.preferredFocusEnvironments
    }
    
    private func configFocusGuide2() {
        self.focusGuide2.heightAnchor.constraint(equalTo: self.moreInfoButton.heightAnchor).isActive = true
        self.focusGuide2.topAnchor.constraint(equalTo: self.moreInfoButton.topAnchor).isActive = true
        self.focusGuide2.rightAnchor.constraint(equalTo: self.backButton.rightAnchor).isActive = true
        self.focusGuide2.widthAnchor.constraint(equalTo: self.backButton.widthAnchor).isActive = true
        self.focusGuide2.preferredFocusEnvironments = self.preferredFocusEnvironments
    }
    
}
