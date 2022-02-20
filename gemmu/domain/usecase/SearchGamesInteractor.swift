//
//  SearchGamesInteractor.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

import Foundation
import Combine

protocol SearchGamesUseCase {

  func searchGames(for: String) -> AnyPublisher<GamesSearchEntity, Error>

}

class SearchGamesInteractor: SearchGamesUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
  func searchGames(for query: String) -> AnyPublisher<GamesSearchEntity, Error> {
    return repository.searchGames(for: query)
  }

}
