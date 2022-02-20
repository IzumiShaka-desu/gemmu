//
//  Developer.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import Foundation
struct Developer: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}
