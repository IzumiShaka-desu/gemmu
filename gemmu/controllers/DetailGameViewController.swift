//
//  DetailGameViewController.swift
//  gemmu
//
//  Created by Akashaka on 11/02/22.
//

import Foundation
import RealmSwift
class DetailGameViewController: ObservableObject {
  @Published var data: GameDetailResponse?
  @Published var isLoading: Bool = true
  @Published var isFavorited: Bool = false
  let dataProvider: GamesDataProvider = GamesDataProvider.shared
  let localDataProvider: GameLocalDataProvider = GameLocalDataProvider.shared
  static let instance=DetailGameViewController()
  func fetchItem(_ idGame: Int) {
    self.isLoading=true
    isFavorited=localDataProvider.isGameFavorited(idGame)
    dataProvider.fetchDetailGame(id: idGame) {result in
      self.data=result
      self.isLoading=false
    }
  }
  func changeStatusFavorited() {
    if let game=data {
      guard let _ = try? Realm() else { return  }
      let newData=FavoriteGame()
      newData.id = game.id
      newData.imageUrl = game.backgroundImage
      for genre in game.genres {
        newData.genres.append(genre.name)
      }
      newData.rank = String(format: "%.1f", game.rating)
      newData.releaseDate = game.released
      newData.name = game.name
      localDataProvider
        .addOrDeleteFavoriteGame(
          favoritedGame: newData,
          isFavorited: isFavorited
        )
      isFavorited=localDataProvider.isGameFavorited(game.id)
    }
  }
}
