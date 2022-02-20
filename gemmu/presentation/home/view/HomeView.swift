//
//  HomeView.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import SwiftUI
import Alamofire

struct HomeView: View {
  @ObservedObject  var homePresenter: HomePresenter

//  @ObservedObject var controller: HomeViewController = HomeViewController.instance
  init(presenter: HomePresenter) {
    self.homePresenter = presenter
    UITableView.appearance().separatorStyle = .none
    UITableViewCell.appearance().backgroundColor = .flatDarkBackground
    UITableView.appearance().backgroundColor = .flatDarkBackground
  }
  var body: some View {
    ZStack(alignment: .top) {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        if homePresenter.isLoading {
          VStack(alignment: .center) {
            ProgressView("loading")
              .frame(
                width: 50,
                height: 50,
                alignment: .center
              )          }
          .frame(
            width: .infinity,
            height: .infinity,
            alignment: .center
          )
        } else {
          List(homePresenter.games, id: \.id) {item in
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
            ).listRowBackground(Color.flatDarkBackground)

            if homePresenter.games.last?.id==item.id { if(homePresenter.next?.count ?? 1)>29 {
              ZStack(alignment: .center) {
                Color.flatDarkCardBackground
                Text("Loading...")
                  .foregroundColor(.white)
                  .onAppear {
                    homePresenter.getGames()
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
      }.onAppear {
        homePresenter.getGames()
      }

    }.padding(0)
  }
}

struct HomeView_Previews: PreviewProvider {
  init() {
    inject()
  }
  static var previews: some View {
    
    HomeView(presenter: Injectors.sharedInstance.homePresenter)
  }
}
