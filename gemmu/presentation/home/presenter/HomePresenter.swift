//
//  HomePresenter.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
//  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var games: [GameItemEntity] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  var next: String?
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getGames() {
    isLoading = true
    homeUseCase.getGames(target: next)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { result in
        self.next = result.next
        self.games.append(contentsOf: result.results)
      })
      .store(in: &cancellables)
  }
//
//  func linkBuilder<Content: View>(
//    for category: CategoryModel,
//    @ViewBuilder content: () -> Content
//  ) -> some View {
//    NavigationLink(
//      destination: router.makeDetailView(for: category)) { content() }
//  }

}
