//
//  GameSearchResponse.swift
//  gemmu
//
//  Created by Akashaka on 11/02/22.
//

import Foundation
struct GamesSearchResponse: Codable {
    let count: Int
    let next: String
    let results: [SearchItemResult]
    let userPlatforms: Bool

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case userPlatforms = "user_platforms"
    }
}
