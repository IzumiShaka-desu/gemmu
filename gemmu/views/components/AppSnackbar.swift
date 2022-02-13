//
//  AppSnackbar.swift
//  Gemmu
//
//  Created by Akashaka on 13/02/22.
//
import SnackBar
class AppSnackBar: SnackBar {

  override var style: SnackBarStyle {
    var style = SnackBarStyle()
    style.background = .flatDarkCardBackground
    style.textColor = .white
    return style
  }
  func showSnacbar(isFavorited: Bool) {
  }

}
