//
//  Injector.swift
//  Gemmu
//
//  Created by Akashaka on 19/02/22.
//

import Foundation
import DIContainer
import RealmSwift
import Network
extension InjectIdentifier {
  
  // datasouce
  
  static var remoteService: InjectIdentifier<RemoteDataSource> {
    .by(type: RemoteDataSource.self, key: "remoteDS")
  }
  static var localService: InjectIdentifier<LocaleDataSource> {
    .by(type: LocaleDataSource.self, key: "localDS")
    
  }
  
  // repository
  
  static var gamesRepo: InjectIdentifier<GamesRepositoryProtocol> {
    .by(type: GamesRepositoryProtocol.self, key: "gamesRepo")
    
  }
  
  // interactor
  
  static var homeInteractor: InjectIdentifier<HomeInteractor> {
    .by(type: HomeInteractor.self, key: "homeInteractor")
    
  }
  static var searchInteractor: InjectIdentifier<SearchGamesInteractor> {
    .by(type: SearchGamesInteractor.self, key: "searchInteractor")
    
  }
  
  static var detailGameInteractor: InjectIdentifier<DetailGameInteractor> {
    .by(type: DetailGameInteractor.self, key: "detailGameInteractor")
    
  }
  
  // router
  
  static var homeRouter: InjectIdentifier<HomeRouter> {
    .by(type: HomeRouter.self, key: "homeRouter")
  }
  
  static var favoriteRouter: InjectIdentifier<FavoriteRouter> {
    .by(type: FavoriteRouter.self, key: "favRouter")
  }
  
  static var searchRouter: InjectIdentifier<SearchRouter> {
    .by(type: SearchRouter.self, key: "searchRouter")
  }
  
  // presenter
  
  static var homePresenter: InjectIdentifier<HomePresenter> {
    .by(type: HomePresenter.self, key: "homePresenter")
    
  }
  static var searchPresenter: InjectIdentifier<SearchGamesPresenter> {
    .by(type: SearchGamesPresenter.self, key: "seachPresenter")
  }
  
  static var detailGamePresenter: InjectIdentifier<DetailGamePresenter> {
    .by(type: DetailGamePresenter.self, key: "detailGamePresenter")
  }
  
  static var favoritePresenter: InjectIdentifier<FavoritePresenter> {
    .by(type: FavoritePresenter.self, key: "favPresenter")
  }
  
}
class Injectors {
  static let sharedInstance=Injectors()
  
  @Injected(.homePresenter) var homePresenter: HomePresenter
  @Injected(.searchPresenter) var searchPresenter: SearchGamesPresenter
  @Injected(.detailGamePresenter) var detailGamePresenter: DetailGamePresenter
  @Injected(.favoritePresenter) var favoritePresenter: FavoritePresenter
  
  func inject() {
    
    // datasource
    
    Container.standard.register(.remoteService) {_ in RemoteDataSource.sharedInstance}
    
    Container.standard.register(.localService) {_ in
      let realm  = try Realm()
      return  LocaleDataSource.sharedInstance(realm)
    }
    
    // repository
    
    Container.standard.register(.gamesRepo) {resolver in
      let localService = try resolver.resolve(.localService)
      let remoteService = try resolver.resolve(.remoteService)
      return GamesRepository.sharedInstance(localService, remoteService)
    }
    
    // interactor
    
    Container.standard.register(.homeInteractor) {resolver in
      let repo = try resolver.resolve(.gamesRepo)
      return HomeInteractor.init(repository: repo)
    }
    
    Container.standard.register(.searchInteractor) {resolver in
      let repo = try resolver.resolve(.gamesRepo)
      return SearchGamesInteractor.init(repository: repo)
    }
    
    Container.standard.register(.detailGameInteractor) { resolver in
      let repo = try resolver.resolve(.gamesRepo)
      return DetailGameInteractor.init(repository: repo)
    }
    
    // router
    
    Container.standard.register(.homeRouter) {_ in HomeRouter()}
    
    Container.standard.register(.favoriteRouter) {_ in FavoriteRouter()}
    
    Container.standard.register(.searchRouter) {_ in SearchRouter()}
    
    // presenter
    
    Container.standard.register(.homePresenter) {resolver in
      let interactor = try resolver.resolve(.homeInteractor)
      let router = try resolver.resolve(.homeRouter)
      return HomePresenter.init(homeUseCase: interactor, router: router)
    }
    
    Container.standard.register(.searchPresenter) {resolver in
      let interactor = try resolver.resolve(.searchInteractor)
      let router =  try resolver.resolve(.searchRouter)
      return SearchGamesPresenter.init(searchUseCase: interactor, router: router)
    }
    
    Container.standard.register(.detailGamePresenter) {resolver in
      let interactor = try resolver.resolve(.detailGameInteractor)
      return DetailGamePresenter.init(usecase: interactor)
    }
    Container.standard.register(.favoritePresenter) {resolver in
      let router =  try resolver.resolve(.favoriteRouter)
      return FavoritePresenter.init(router: router)
    }
  
}
  
  //    container.register(LocaleDataSource.self) {_ in
  //      let realm=try? Realm()
  //      let _ = print("injecting")
  //      return  LocaleDataSource.sharedInstance(realm)
  //    }
  //    container.register(RemoteDataSource.self) {_ in
  //      return RemoteDataSource.sharedInstance
  //    }
  //    container.register(GamesRepository.self) {resolver in
  //      return GamesRepository.sharedInstance(
  //        resolver.resolve(LocaleDataSource.self)!,
  //        resolver.resolve(RemoteDataSource.self)!
  //      )
  //    }
  //    container.register(HomeInteractor.self) {resolver in
  //      return HomeInteractor.init(repository: resolver.resolve(GamesRepository.self)!)
  //    }
  //
  //    container.register(SearchGamesInteractor.self) {resolver in
  //      return SearchGamesInteractor.init(repository: resolver.resolve(GamesRepository.self)!)
  //    }
}
