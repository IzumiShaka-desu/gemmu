//
//  ContentView.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import SwiftUI
import About
struct ContentView: View {

  init() {
    UITabBar.appearance().backgroundColor = UIColor.flatDarkBackground
    UINavigationBar.appearance().backgroundColor = UIColor.flatDarkBackground
    
  }
  
  var body: some View {
    ZStack {
      Color.flatWhiteBackground.ignoresSafeArea(.all)
      NavigationView {
        
        TabView {
          ZStack(alignment: .top) {
           
            Color.flatDarkBackground.ignoresSafeArea()
            HomeView(presenter: Injectors.sharedInstance.homePresenter)
              .accentColor(Color.white)
          }.tabItem {
            Label("Home", systemImage: "house.circle")
          }
          
          ZStack {
            Color.flatDarkBackground.ignoresSafeArea()
            SearchView(presenter: Injectors.sharedInstance.searchPresenter)
          }.tabItem {
            Image(systemName: "magnifyingglass.circle")
            Text("Search")
          }
          ZStack {
            Color.flatDarkBackground.ignoresSafeArea()
            FavoriteView(presenter: Injectors.sharedInstance.favoritePresenter)
              .accentColor(Color.white)
          }.tabItem {
            Image(systemName: "star.circle.fill")
            Text("Favourite")
          }
        }
        .accentColor(Color.flatWhiteBackground)
        .navigationTitle("Game Store")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: AboutView(), label: {
              HStack {
                Image(systemName: "info.circle").imageScale(.medium)
                Text("About")
              }
              
            }
            ).navigationTitle("back")
          }
          
        }
      }
      
    }.preferredColorScheme(.dark)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
