//
//  Rating.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import Foundation
struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double
}
