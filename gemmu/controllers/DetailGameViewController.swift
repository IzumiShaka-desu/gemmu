//
//  DetailGameViewController.swift
//  gemmu
//
//  Created by Akashaka on 11/02/22.
//

import Foundation
class DetailGameViewController: ObservableObject {
    @Published var data: GameDetailResponse?
    @Published var isLoading: Bool = true
    let dataProvider: GamesDataProvider = GamesDataProvider()
    static let instance=DetailGameViewController()

    func fetchItem(_ idGame: Int) {
        self.isLoading=true
        dataProvider.fetchDetailGame(id: idGame) {result in
            self.data=result
            self.isLoading=false
        }
    }
}
