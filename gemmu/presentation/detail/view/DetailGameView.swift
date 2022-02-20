//
//  DetailGameView.swift
//  gemmu
//
//  Created by Akashaka on 11/02/22.
//
import SwiftUI
import NetworkImage
import PopupView

struct DetailGameView: View {
  @ObservedObject var presenter: DetailGamePresenter
  var idGame: Int
  init(gameId: Int, presenter: DetailGamePresenter) {
    self.idGame = gameId
    self.presenter = presenter
    
    UITabBar.appearance().backgroundColor = UIColor.flatDarkBackground
    UINavigationBar.appearance().backgroundColor = UIColor.flatWhiteBackground
    UINavigationBar.appearance().barTintColor = UIColor.white
  }
  
  var body: some View {
    
    ZStack {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        if self.presenter.isLoading {
          ProgressView().padding(16)
        } else {
          
          if let gameDetail=presenter.gameDetail {
            if  presenter.isError {
              Text(presenter.errorMessage)
                .frame(
                  height: 50,
                  alignment: .center
                )
                .padding(16)
                .font(.headline)
            } else {
              PageBody(gameDetail: gameDetail, presenter: presenter)
            }
          } else {
            Text(" data not Loaded")
          }
          
        }
        
      }
      
    }.onAppear {
      presenter.loadDetail(for: idGame)
      presenter.checkIsFavorited()
    }
    
  }
  
}
private struct PageBody: View {
  var gameDetail: GameDetailEntity
  @ObservedObject var presenter: DetailGamePresenter
  var body: some View {
    ZStack {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        HStack {
          NetworkImage(url: URL(string: gameDetail.imageUrl)) { image in
            image.resizable()
            
          } placeholder: {
            ProgressView()
            
          } fallback: {
            Image(systemName: "photo")
            
          }
          .frame(width: 150, height: 150)
          .clipped()
          .background(Color.white)
          .cornerRadius(10)
          
          VStack(alignment: .leading) {
            
            Text(gameDetail.name)
              .font(.title)
              .fixedSize(
                horizontal: false,
                vertical: true
              )
            
            Text(gameDetail.publisher)
              .font(.subheadline)
            
            HStack {
              Image(systemName: "star.fill")
              Text(String(format: "%.1f", gameDetail.rating))
                .font(.subheadline)
              
            }
            Button(action: {
              presenter.changeStatusFavorited()
            },
                   label: {
              if presenter.isFavorited {
                Image(systemName: "star.square.fill")
                Text("Favourited")
                
              } else {
                Image(systemName: "plus.circle")
                Text("add to favourite")
                
              }
            })
          }
          
        }.padding(8)
        
        Text("Release date")
          .font(.title3)
        Text(gameDetail.releaseDate)
        Text("Platforms")
          .font(.title3)
        GeometryReader {geometry in
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(gameDetail.platforms, id: \.self) { platform in
                TagsCard(
                  text: platform,
                  bgColor: Color.pink
                )
              }
            }.frame(width: geometry.size.width)
          }
        }.frame(height: 56)
        Text("Genre")
          .font(.title3)
        HStack {
          ForEach(gameDetail.genres, id: \.self) { genre in
            TagsCard(
              text: genre,
              bgColor: Color.pink
            )
          }
          
        }
        Text("Description")
          .font(.title3)
        
        ScrollView {
          Text(gameDetail.description)
            .font(.body)
            .padding(16)
        }
        
      }
    }.popup(
      isPresented: $presenter.isShowingPopUp,
      type: .toast,
      position: .bottom,
      animation: .easeInOut,
      autohideIn: 2,
      closeOnTap: true,
      view: {
        Toast(message: presenter.popUpMessage)
      }
    )
  }
  
}
struct Toast: View {
  var message: String
  var body: some View {
    ZStack {
      Color.flatDarkCardBackground
      HStack {
        Image(systemName: "bell")
          .resizable()
          .frame(
            width: 18,
            height: 18,
            alignment: .center
          )
          .foregroundColor(Color.white)
          .padding()
        Spacer()
        Text(message)
          .foregroundColor(.white)
        Spacer()
        Spacer()
      }
      .padding()
    }.frame(height: 50)
      .cornerRadius(12)
      .padding()
    
  }
}
struct DetailGameView_Previews: PreviewProvider {
  init() {
    Injectors.sharedInstance.inject()
  }
  static var previews: some View {
    DetailGameView(gameId: 3498, presenter: Injectors.sharedInstance.detailGamePresenter)
  }
}
