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
              )
          }.onAppear {
            homePresenter.getGames()
          }
          .frame(
            width: .infinity,
            height: .infinity,
            alignment: .center
          )
        } else {
          if homePresenter.isError {
            Text(homePresenter.errorMessage)
              .font(.headline)
          } else {
           List(homePresenter.games, id: \.id) {item in
             homePresenter.linkBuilder(for: item.id) {
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
             }.listRowBackground(Color.flatDarkBackground)
            if homePresenter.games.last?.id==item.id {
              if(homePresenter.next?.count ?? 1)>29 {
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
        }
      }
      
    }.padding(0)
  }
}

struct HomeView_Previews: PreviewProvider {
  init() {
    Injectors.sharedInstance.inject()
  }
  static var previews: some View {
    
    HomeView(presenter: Injectors.sharedInstance.homePresenter)
  }
}
