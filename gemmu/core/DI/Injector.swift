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
import Common
import Home
import Detail
import Search
import Favorite

extension InjectIdentifier {
  
  // datasouce
  
  static var homeService: InjectIdentifier<HomeRemoteDataSourceProtocol> {
    .by(type: HomeRemoteDataSourceProtocol.self, key: "homeDS")
  }
  static var detailService: InjectIdentifier<DetailDataSourceProtocol> {
    .by(type: DetailDataSourceProtocol.self, key: "detailDS")
  }
  static var searchService: InjectIdentifier<SearchRemoteDataSourceProtocol> {
    .by(type: SearchRemoteDataSourceProtocol.self, key: "searchDS")
  }
  static var localService: InjectIdentifier<LocaleDataSourceProtocol> {
    .by(type: LocaleDataSourceProtocol.self, key: "localDS")
  }
  
  // repository
  
  static var homeRepo: InjectIdentifier<HomeRepositoryProtocol> {
    .by(type: HomeRepositoryProtocol.self, key: "homeRepo")
  }
  static var detailRepo: InjectIdentifier<DetailGamesRepositoryProtocol> {
    .by(type: DetailGamesRepositoryProtocol.self, key: "detailRepo")
  }
  static var searchRepo: InjectIdentifier<SearchGamesRepositoryProtocol> {
    .by(type: SearchGamesRepositoryProtocol.self, key: "searchRepo")
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
  
  static var homeRouter: InjectIdentifier<Router> {
    .by(type: Router.self, key: "router")
  }
  
  // presenter
  
  static var homePresenter: InjectIdentifier<HomePresenter<DetailGameView>> {
    .by(type: HomePresenter.self, key: "homePresenter")
    
  }
  static var searchPresenter: InjectIdentifier<SearchGamesPresenter<DetailGameView>> {
    .by(type: SearchGamesPresenter.self, key: "seachPresenter")
  }
  
  static var detailGamePresenter: InjectIdentifier<DetailGamePresenter> {
    .by(type: DetailGamePresenter.self, key: "detailGamePresenter")
  }
  
  static var favoritePresenter: InjectIdentifier<FavoritePresenter<DetailGameView>> {
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
    injectDatasources()
    injectRepositories()
    injectInteractor()
    injectRouter()
    injectPresenter()
  }
  
  func injectRouter() {
    // router
    
    Container.standard.register(.homeRouter) {_ in Router.sharedInstance}
    
  }
  func injectPresenter() {
    // presenter
    
    Container.standard.register(.homePresenter) {resolver in
      let interactor = try resolver.resolve(.homeInteractor)
      let router = try resolver.resolve(.homeRouter)
      return HomePresenter(homeUseCase: interactor) {id in
        router.makeDetailView(for: id)
      }
    }
    
    Container.standard.register(.searchPresenter) {resolver in
      let interactor = try resolver.resolve(.searchInteractor)
      let router =  try resolver.resolve(.homeRouter)
      return SearchGamesPresenter.init(searchUseCase: interactor) {id in
        router.makeDetailView(for: id)
      }
    }
    
    Container.standard.register(.detailGamePresenter) {resolver in
      let interactor = try resolver.resolve(.detailGameInteractor)
      return DetailGamePresenter.init(usecase: interactor)
    }
    Container.standard.register(.favoritePresenter) {resolver in
      let router =  try resolver.resolve(.homeRouter)
      return FavoritePresenter {id in
        router.makeDetailView(for: id)
      }
    }
  }
     func injectInteractor() {
      // interactor
      
      Container.standard.register(.homeInteractor) {resolver in
        let repo = try resolver.resolve(.homeRepo)
        return HomeInteractor(repository: repo)
      }
      
      Container.standard.register(.searchInteractor) {resolver in
        let repo = try resolver.resolve(.searchRepo)
        return SearchGamesInteractor.init(repository: repo)
      }
      
      Container.standard.register(.detailGameInteractor) { resolver in
        let repo = try resolver.resolve(.detailRepo)
        return DetailGameInteractor(repository: repo)
      }
    }
     func injectDatasources() {
      // datasource
      
      Container.standard.register(.homeService) {_ in HomeRemoteDataSource.sharedInstance}
      
      Container.standard.register(.detailService) {_ in DetailRemoteDataSource.sharedInstance}
      
      Container.standard.register(.searchService) {_ in SearchRemoteDataSource.sharedInstance}
      
      Container.standard.register(.localService) {_ in
        let realm  = try Realm()
        return  LocaleDataSource.sharedInstance(realm)
      }
      
    }
     func injectRepositories() {
      // repository
      Container.standard.register(.homeRepo) {resolver in
        let homeService = try resolver.resolve(.homeService)
        return HomeRepository.sharedInstance(homeService)
      }
      Container.standard.register(.detailRepo) {resolver in
        let detailService = try resolver.resolve(.detailService)
        let localService = try resolver.resolve(.localService)
        return DetailGamesRepository.sharedInstance(
          detailService ,
          localService
        )
      }
      Container.standard.register(.searchRepo) {resolver in
        let searchService =  try resolver.resolve(.searchService)
        return SearchGamesRepository.sharedInstance(searchService)
      }
      
    }
  
}
