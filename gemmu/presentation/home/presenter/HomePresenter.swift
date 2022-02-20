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
  private let router: HomeRouter
  private let homeUseCase: HomeUseCase
  
  @Published var games: [GameItemEntity] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var isError: Bool = false
  var next: String?
  
  init(homeUseCase: HomeUseCase, router: HomeRouter) {
    self.homeUseCase = homeUseCase
    self.router = router
  }
  
  func getGames() {
    if next == nil {
      isLoading = true
    }
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
  
  func linkBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: id)) { content() }
    .padding(0)
    .buttonStyle(PlainButtonStyle())
  }
  
}
