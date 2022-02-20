//
//  GamesRepository.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//
import Combine
import Foundation
protocol GamesRepositoryProtocol {
  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error>
  func searchGames(for query: String) -> AnyPublisher<GamesSearchEntity, Error>
  func getDetailGame(for id: Int) -> AnyPublisher<GameDetailEntity, Error>
  func addOrDeleteFavoriteGame(favoritedGame: FavoriteGame, isFavorited: Bool)
  func isGameFavorited(for id: Int) -> AnyPublisher<Bool, Error>
}
final class GamesRepository: NSObject {
  typealias GamesInstance = (LocaleDataSource, RemoteDataSource) -> GamesRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }
  
  static let sharedInstance: GamesInstance = { localeRepo, remoteRepo in
    return GamesRepository(locale: localeRepo, remote: remoteRepo)
  }
  
}
extension GamesRepository: GamesRepositoryProtocol {
  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error> {
    return self.remote
      .getGames(target: target)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }
  
  func searchGames(for query: String) -> AnyPublisher<GamesSearchEntity, Error> {
    return self.remote
      .searchGames(for: query)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }
  
  func getDetailGame(for id: Int) -> AnyPublisher<GameDetailEntity, Error> {
    return self.remote
      .getDetailGame(for: id)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }
  func isGameFavorited(for id: Int) -> AnyPublisher<Bool, Error> {
    return self.locale
      .isGameFavorited(for: id)
      .eraseToAnyPublisher()
  }
  func addOrDeleteFavoriteGame(favoritedGame: FavoriteGame, isFavorited: Bool) {
    self.locale
      .addOrDeleteFavoriteGame(
        favoritedGame: favoritedGame,
        isFavorited: isFavorited
      )
  }
}
