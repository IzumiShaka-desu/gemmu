//
//  FavoriteGame.swift
//  Gemmu
//
//  Created by Akashaka on 12/02/22.
//

import RealmSwift

class FavoriteGame: Object, Identifiable {
  @Persisted(primaryKey: true) var id: Int
  @Persisted var name: String
  @Persisted var imageUrl: String
  @Persisted var genres: List<String>
  @Persisted var releaseDate: String
  @Persisted var rank: String
}
