//
//  SearchView.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var controller: SearchViewController = SearchViewController.instance

  @State private var isEditing = false

  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        HStack(alignment: .top) {
          TextField("Search ...", text: $controller.query )
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
                self.controller.executeSearch()
              }
              label: {
                Image(systemName: "magnifyingglass.circle")
                  .frame(width: 40, height: 40)
              }
              Button {
                self.isEditing = false
                self.controller.query = ""
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
            if self.controller.isLoading {
              ProgressView().padding(16)
            } else {
              if let games=controller.searchResult?.results {
                List(games, id: \.id) {item in
                  ItemList(
                    title: item.name,
                    releaseDate: item.released ?? "",
                    platforms: [],
                    genres: item.extractGenreName(),
                    imageUrl: item.backgroundImage ?? "",
                    id: item.id
                  ).frame(
                    width: .infinity,
                    height: 150
                  ).listRowBackground(Color.flatDarkBackground)
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
  static var previews: some View {
    SearchView()
  }
}
