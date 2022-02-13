//
//  GamesLocalDataProvider.swift
//  Gemmu
//
//  Created by Akashaka on 13/02/22.
//
import RealmSwift
class GameLocalDataProvider{
  @ObservedResults(FavoriteGame.self) var games
  static let shared = GameLocalDataProvider()
  
  func isGameFavorited(_ idGame: Int)->Bool{
    guard let realm = try? Realm() else { return false }
    return realm.object(ofType: FavoriteGame.self, forPrimaryKey: idGame) != nil
  }
  
  func addOrDeleteFavoriteGame(favoritedGame: FavoriteGame,isFavorited: Bool){
    guard let realm = try? Realm() else { return  }
    if isFavorited{
      guard let object=realm.object(ofType: FavoriteGame.self, forPrimaryKey: favoritedGame._id) else { return }
      $games.remove(object)
    }else{
      $games.append(favoritedGame)
    }
    
  }
  
}
