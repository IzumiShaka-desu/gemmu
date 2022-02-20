//
//  Extensionn.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import Foundation
import SwiftUI
extension UIColor {
    static let flatDarkBackground = UIColor(red: 36, green: 36, blue: 36)
    static let flatDarkCardBackground = UIColor(red: 46, green: 46, blue: 46)
    static let flatWhiteBackground = UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)

    convenience init(red: Int,
                     green: Int,
                     blue: Int,
                     alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}

extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }

    public static var flatDarkBackground: Color {
        return Color(decimalRed: 36, green: 36, blue: 36)
    }
    public static var flatWhiteBackground: Color {Color(red: 255, green: 255, blue: 255, opacity: 0.3)}

    public static var flatDarkCardBackground: Color {
        return Color(decimalRed: 46, green: 46, blue: 46)
    }
}
