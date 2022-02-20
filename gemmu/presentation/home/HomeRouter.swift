//
//  HomeRouter.swift
//  Gemmu
//
//  Created by Akashaka on 19/02/22.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for id: Int) -> some View {
    let presenter = Injectors.sharedInstance.detailGamePresenter
    return DetailGameView(gameId: id, presenter: presenter)
  }
  
}
