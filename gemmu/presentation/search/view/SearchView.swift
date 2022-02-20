//
//  SearchView.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchGamesPresenter
  @State private var isEditing = false
  init(presenter: SearchGamesPresenter) {
    self.presenter=presenter
  }
  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        HStack(alignment: .top) {
          TextField("Search ...", text: $presenter.query )
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onTapGesture {
              self.isEditing = true
            }
          if isEditing {
            HStack {
              Button {
                self.presenter.searchGames()
              }
              label: {
                Image(systemName: "magnifyingglass.circle")
                  .frame(width: 40, height: 40)
              }
              Button {
                self.isEditing = false
                self.presenter.query = ""
              }
              label: {
                Text("Cancel")
              }
            }.padding(.trailing, 10)
              .transition(.move(edge: .trailing))
              .animation(.default)
          }
        }.padding(16)
        ZStack(alignment: .top) {
          Color.flatDarkBackground.ignoresSafeArea()
          VStack {
            if self.presenter.isLoading {
              ProgressView().padding(16)
            } else {
              if let games=presenter.results {
                List(games, id: \.id) {item in
                  presenter.linkBuilder(for: item.id) {
                    ItemList(
                     title: item.name,
                     releaseDate: item.released,
                     platforms: [],
                     genres: item.genres,
                     imageUrl: item.imageUrl,
                     id: item.id
                   ).frame(
                     width: .infinity,
                     height: 150
                   )
                  }
                  .listRowBackground(Color.flatDarkBackground)
                  
                }
              } else {
                Text("Search result empty")
              }
            }
          }
        }.padding(0)
      }
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  init() {
    Injectors.sharedInstance.inject()
  }

  static var previews: some View {
        SearchView(presenter: Injectors.sharedInstance.searchPresenter)
  }
}
