//
//  SearchViewController.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import Foundation
class SearchViewController: ObservableObject {
  static let instance=SearchViewController()
  let dataProvider: GamesDataProvider = GamesDataProvider()
  @Published var isLoading: Bool = false
  @Published var query: String = ""
  @Published var searchResult: GamesSearchResponse?
  func executeSearch() {
    self.isLoading=true
    dataProvider
      .fetchSearchGames(query: query) {result in
        self.searchResult = result
        self.isLoading=false
      }
      }
}
