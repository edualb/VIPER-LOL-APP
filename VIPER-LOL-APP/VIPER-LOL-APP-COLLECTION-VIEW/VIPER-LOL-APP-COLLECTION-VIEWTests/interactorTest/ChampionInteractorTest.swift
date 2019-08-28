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

let rotationsMock = ChampionRotations(rotation: [ChampionId(10)], newPlayerRotation: [ChampionId(18)], maxNewPlayerLevel: 10)
let championEntityMock = ChampionEntity(name: "Kayle",
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
                                    imgSkins: [
                                        ImageWithUrl(url: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/Kayle_0.jpg", image: nil),
                                        ImageWithUrl(url: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/Kayle_1.jpg", image: nil)
                                    ])

final class ChampionInteractorTest: XCTestCase {
    
    var interactor: ChampionWeekInteractorProtocol!
    var champion: ChampionEntity?
    var errorMsg: String?

    override func setUp() {}

    override func tearDown() {
        self.interactor = nil
        self.errorMsg = nil
        self.champion = nil
    }

    func testFetchWithChampionsAndChampion() {
        self.interactor = ChampionInteractor(orchestration: WithChampionsAndChampionMockOrchestration())
        self.interactor.setDelegate(delegate: self)
        self.interactor.fetch()
        XCTAssertNotNil(champion)
        XCTAssertNil(errorMsg)
    }
    
    func testFetchWithoutChampionsAndChampion() {
        self.interactor = ChampionInteractor(orchestration: WithoutChampionsAndChampionMockOrchestration())
        self.interactor.setDelegate(delegate: self)
        self.interactor.fetch()
        XCTAssertNil(champion)
        XCTAssertNotNil(errorMsg)
    }
    
    func testFetchWithoutChampion() {
        self.interactor = ChampionInteractor(orchestration: WithoutChampionMockOrchestration())
        self.interactor.setDelegate(delegate: self)
        self.interactor.fetch()
        XCTAssertNil(champion)
        XCTAssertNotNil(errorMsg)
    }
    
    func testFetchWithoutChampions() {
        self.interactor = ChampionInteractor(orchestration: WithoutChampionsMockOrchestration())
        self.interactor.setDelegate(delegate: self)
        self.interactor.fetch()
        XCTAssertNil(champion)
        XCTAssertNotNil(errorMsg)
    }
}

extension ChampionInteractorTest: ChampionWeekInteractorDelegate {
    func fetchFailed(errorMsg: String) {
        self.errorMsg = errorMsg
    }
    
    func fetched(champion: ChampionEntity) {
        if self.champion == nil {
            self.champion = champion
        }
    }
}

final class WithChampionsAndChampionMockOrchestration: ChampionOrchestrationProtocol {
    func getChampions(completion: @escaping (ChampionRotations?, String?) -> Void) {
        completion(rotationsMock, nil)
    }
    
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void) {
        completion(championEntityMock, nil)
    }
}

final class WithoutChampionsAndChampionMockOrchestration: ChampionOrchestrationProtocol {
    func getChampions(completion: @escaping (ChampionRotations?, String?) -> Void) {
        completion(nil, "Default error")
    }
    
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void) {
        completion(nil, "Default error")
    }
}

final class WithoutChampionMockOrchestration: ChampionOrchestrationProtocol {
    func getChampions(completion: @escaping (ChampionRotations?, String?) -> Void) {
        completion(rotationsMock, nil)
    }
    
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void) {
        completion(nil, "Default error")
    }
}

final class WithoutChampionsMockOrchestration: ChampionOrchestrationProtocol {
    func getChampions(completion: @escaping (ChampionRotations?, String?) -> Void) {
        completion(nil, "Default error")
    }
    
    func getChampion(by id: ChampionId, completion: @escaping (ChampionEntity?, String?) -> Void) {
        completion(championEntityMock, nil)
    }
}

