//
//  gemmuApp.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import SwiftUI

@main
struct GemmuApp: App {
  init() {
    Injectors.sharedInstance.inject()
  }
  var body: some Scene {
    WindowGroup {
     ContentView()
    }
  }
}
