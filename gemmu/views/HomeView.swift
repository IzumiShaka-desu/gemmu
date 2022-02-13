//
//  HomeView.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import SwiftUI
import Alamofire

struct HomeView: View {
  @ObservedObject var controller: HomeViewController = HomeViewController.instance
  init() {
    UITableView.appearance().separatorStyle = .none
    UITableViewCell.appearance().backgroundColor = .flatDarkBackground
    UITableView.appearance().backgroundColor = .flatDarkBackground
  }
  var body: some View {
    ZStack(alignment: .top) {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        if controller.isLoading {
          VStack(alignment: .center) {
            ProgressView("loading")
              .frame(
                width: 50,
                height: 50,
                alignment: .center
              ).onAppear {
                controller.fetchItems()
              }
          }
          .frame(
            width: .infinity,
            height: .infinity,
            alignment: .center
          )
        } else {
          List(controller.data, id: \.id) {item in
            ItemList(
              title: item.name ?? "",
              releaseDate: item.released ?? "",
              platforms: [],
              genres: item.extractGenreName(),
              imageUrl: item.backgroundImage ?? "",
              id: item.id
            ).frame(
              width: .infinity,
              height: 150
            ).listRowBackground(Color.flatDarkBackground)

            if controller.data.last?.id==item.id { if(controller.nextPage?.count ?? 1)>29 {
              ZStack(alignment: .center) {
                Color.flatDarkCardBackground
                Text("Loading...")
                  .foregroundColor(.white)
                  .onAppear {
                    controller.fetchItems()
                  }
              }.listRowBackground(Color.flatDarkBackground)

            } else {
              ZStack(alignment: .center) {
                Color.flatDarkCardBackground
                Text("end of list")
                  .foregroundColor(.white)
              }.listRowBackground(Color.flatDarkBackground)
            }
            }
          }
        }
      }
    }.padding(0)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
