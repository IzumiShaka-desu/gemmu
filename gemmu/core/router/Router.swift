//
//  Router.swift
//  Gemmu
//
//  Created by Akashaka on 28/02/22.
//
import SwiftUI
import Detail
final class Router {
  static let sharedInstance = Router()
  func makeDetailView(for id: Int) -> DetailGameView {
    let presenter = Injectors.sharedInstance.detailGamePresenter
    return DetailGameView(gameId: id, presenter: presenter)
  }
}
