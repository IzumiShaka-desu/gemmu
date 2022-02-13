//
//  HomeViewController.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import Combine
class HomeViewController: ObservableObject {
  static let instance=HomeViewController()
  @Published var isLoading: Bool = true
  @Published var data: [GameItem] = []
  var nextPage: String?
  let dataProvider: GamesDataProvider = GamesDataProvider()
  
  func fetchItems() {
    if data.isEmpty {
      self.isLoading=true
    }
    dataProvider
      .fetchGames(currentTarget: nextPage) {result in
        if let results: [GameItem] = result?.results {
          self.nextPage=result?.next
          self.data.append(contentsOf: results)
          self.isLoading=false
        }
      }
  }
}
