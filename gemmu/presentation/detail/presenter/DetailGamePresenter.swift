//
//  DetailGamePresenter.swift
//  Gemmu
//
//  Created by Akashaka on 19/02/22.
//
import SwiftUI
import Combine
import RealmSwift

class DetailGamePresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let usecase: DetailGameUseCase
  
  @Published var gameDetail: GameDetailEntity?
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var isFavorited = false
  @Published var isError: Bool = false
  @Published var isShowingPopUp: Bool = false
  @Published var popUpMessage: String = ""
  var id: Int = -1
  var next: String?
  
  init(usecase: DetailGameUseCase) {
    self.usecase = usecase
  }
  
  func loadDetail(for id: Int) {
    if self.id != id {
      isLoading = true
      usecase.getDetailGame(for: id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isError = true
            self.isLoading = false
          case .finished:
            self.isError = false
            self.errorMessage = ""
            self.isLoading = false
          }
        }, receiveValue: { result in
          self.gameDetail=result
          
        })
        .store(in: &cancellables)
      self.id = id
    }
    
  }
  func checkIsFavorited() {
    if  id != -1 {
      usecase.isGameFavorited(by: id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.popUpMessage = error.localizedDescription
          case .finished: break
          }
        }, receiveValue: {result in
          self.isFavorited = result
          self.popUpMessage = result ? "game has added to favorite list" : "game has removed from favorite list"
        })
        .store(in: &cancellables)
    }
    
  }
  
  func changeStatusFavorited() {
    if let gameDetail = self.gameDetail {
      
      usecase.addOrDeleteFavorite(
        for: gameDetail,
           isFavorited: isFavorited
      )
      self.checkIsFavorited()
      isShowingPopUp=true
    }
    
  }
}
