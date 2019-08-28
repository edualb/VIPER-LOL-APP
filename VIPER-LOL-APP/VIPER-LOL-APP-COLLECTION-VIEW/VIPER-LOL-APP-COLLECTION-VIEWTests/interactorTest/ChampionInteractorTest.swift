//
//  ChampionInteractorTest.swift
//  VIPER-LOL-APP-COLLECTION-VIEWTests
//
//  Created by eduardo.silva on 26/08/19.
//  Copyright © 2019 eduardo.silva. All rights reserved.
//

import XCTest
import LeagueAPI
@testable import VIPER_LOL_APP_COLLECTION_VIEW

class ChampionMockOrchestration: ChampionOrchestrationProtocol {
    func getChampions(completion: @escaping (ChampionRotations) -> Void) {
        completion(ChampionRotations(rotation: [ChampionId(10)], newPlayerRotation: [ChampionId(18)], maxNewPlayerLevel: 10))
    }
    
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void) {
        let imgSkin0 = ImageWithUrl(url: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/Kayle_0.jpg", image: nil)
        let imgSkin1 = ImageWithUrl(url: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/Kayle_1.jpg", image: nil)
        let skins = [imgSkin0, imgSkin1]
        completion(ChampionEntity(name: "Kayle",
                                  title: "the Righteous",
                                  description: "Born to a Targonian Aspect at the height of the Rune Wars, Kayle honored her mother\'s legacy by fighting for justice on wings of divine flame. She and her twin sister Morgana were the protectors of Demacia for many years—until Kayle became disillusioned...",
                                  img: ImageWithUrl(
                                            url:  "https://ddragon.leagueoflegends.com/cdn/9.17.1/img/champion/Kayle.png",
                                            image: nil
                                        ),
                                  imgLoading: ImageWithUrl(
                                            url:  "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/Kayle_0.jpg",
                                            image: nil
                                        ),
                                  imgSkins: skins), nil)
    }
    
    
}

class ChampionInteractorTest: XCTestCase {
    
    var interactor: ChampionWeekInteractorProtocol!
    var champion: ChampionEntity?

    override func setUp() {
        self.interactor = ChampionInteractor(orchestration: ChampionMockOrchestration())
        self.interactor.setDelegate(delegate: self)
    }

    override func tearDown() {
        self.interactor = nil
    }

    func testFetch() {
        self.interactor.fetch()
        XCTAssertNotNil(champion)
    }
}

extension ChampionInteractorTest: ChampionWeekInteractorDelegate {
    func fetched(champion: ChampionEntity) {
        if self.champion == nil {
            self.champion = champion
        }
    }
    
    func fetchFailed() {
        
    }
}

