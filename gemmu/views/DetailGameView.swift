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
  var gameId: Int
  @ObservedObject var controller: DetailGameViewController
  
  init(gameId: Int, controller: DetailGameViewController) {
    self.gameId=gameId
    self.controller=controller
    UITabBar.appearance().backgroundColor = UIColor.flatDarkBackground
    UINavigationBar.appearance().backgroundColor = UIColor.flatWhiteBackground
    UINavigationBar.appearance().barTintColor = UIColor.white
  }
  
  var body: some View {
    
    ZStack {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        if self.controller.isLoading {
          ProgressView().padding(16)
        } else {
          
          if let gameDetail=controller.data {
            PageBody(gameDetail: gameDetail, controller: controller)
          } else {
            Text(" data not Loaded")
          }
          
        }
        
      }.onAppear {
        controller.fetchItem(gameId)
      }
    }
    
  }
  
}
private struct PageBody: View {
  var gameDetail: GameDetailResponse
  @State var isShowingPopUp: Bool = false
  @ObservedObject var controller: DetailGameViewController
  var body: some View {
    ZStack {
      Color.flatDarkBackground.ignoresSafeArea()
      VStack {
        HStack() {
          NetworkImage(url: URL(string:gameDetail.backgroundImage)) { image in
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
          VStack(alignment:.leading){
            
            Text(gameDetail.name)
              .font(.title)
              .fixedSize(
                horizontal: false,
                vertical: true
              )
            
            Text(gameDetail.publishers.first?.name ?? "-")
              .font(.subheadline)
            HStack {
              Image(systemName: "star.fill")
              Text(String(format: "%.1f", gameDetail.rating))
                .font(.subheadline)
              
            }
            Button(action: {
              controller.changeStatusFavorited()
              self.isShowingPopUp=true
            },
                   label: {
              if controller.isFavorited{
                Image(systemName: "star.square.fill")
                Text("Favourited")
                
              }else{
                Image(systemName: "plus.circle")
                Text("add to favourite")
                
              }
            })
          }
          
          
        }.padding(8)
        
        Text("Release date")
          .font(.title3)
        Text(gameDetail.released)
        Text("Platforms")
          .font(.title3)
        HStack {
          ForEach(gameDetail.parentPlatforms, id: \.platform.id) { platform in
            TagsCard(
              text: platform.platform.name,
              bgColor: Color.pink
            )
          }
          
        }
        Text("Genre")
          .font(.title3)
        HStack {
          ForEach(gameDetail.genres, id: \.id) { genre in
            TagsCard(
              text: genre.name,
              bgColor: Color.pink
            )
          }
          
        }
        Text("Description")
          .font(.title3)
        
        ScrollView {
          Text(gameDetail.descriptionRaw)
            .font(.body)
            .padding(16)
        }
        
      }
    }.popup(
      isPresented:$isShowingPopUp,
      type: .toast,
      position: .bottom,
      animation:.easeInOut,
      autohideIn: 2,
      closeOnTap: true,
      view: {
        Toast(isFavorited: controller.isFavorited)
      }
    )
  }
  
}
struct Toast:View{
  var isFavorited: Bool
  var body: some View{
    ZStack {
      Color.flatDarkCardBackground
      HStack {
        Image (systemName: "bell")
          .resizable()
          .frame (
            width: 18,
            height: 18,
            alignment:.center
          )
          .foregroundColor(Color.white)
          .padding()
        Spacer()
        Text(isFavorited ? "added to favourite" : "removed from favourite")
          .foregroundColor(.white)
        Spacer()
        Spacer()
      }
      .padding()
    }.frame(height:50)
    .cornerRadius(12)
    .padding()
    
  }
}
struct DetailGameView_Previews: PreviewProvider {
  static var previews: some View {
    DetailGameView(gameId: 3498, controller: DetailGameViewController.instance)
  }
}
