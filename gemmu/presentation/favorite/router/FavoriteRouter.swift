//
//  FavoriteRouter.swift
//  Gemmu
//
//  Created by Akashaka on 20/02/22.
//

import SwiftUI

class FavoriteRouter {

  func makeDetailView(for id: Int) -> some View {
    let presenter = Injectors.sharedInstance.detailGamePresenter
    return DetailGameView(gameId: id, presenter: presenter)
  }
  
}
