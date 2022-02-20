//
//  HomeInteractor.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error> {
    return repository.getGames(target: target)
  }

}
