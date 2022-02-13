//
//  PlatformSpesific.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
struct PlatformSpesific: Codable {
    let id: Int
    let name, slug: String
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
