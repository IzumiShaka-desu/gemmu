//
//  FavoriteView.swift
//  Gemmu
//
//  Created by Akashaka on 12/02/22.
//

import SwiftUI
import RealmSwift

struct FavoriteView: View {
  @ObservedResults(FavoriteGame.self) var games

  var body: some View {
    ZStack(alignment: .top) {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        if games.isEmpty {
          Text("You don't have any favourite games")
        } else {
          List(games, id: \.id) {item in
              ItemList(
                title: item.name ,
                releaseDate: item.releaseDate,
                platforms: [item.rank],
                genres: item.genres.sorted(),
                imageUrl: item.imageUrl,
                id: item.id
              ).frame(
                width: .infinity,
                height: 150
              )
              .listRowBackground(Color.flatDarkBackground)
          }
        }
      }

    }.padding(0)
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView()
  }
}
