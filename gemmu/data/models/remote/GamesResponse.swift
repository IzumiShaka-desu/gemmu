//
//  GamesResponse.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
// MARK: - GamesResponse
struct GamesResponse: Codable {
    let count: Int
    let next: String
    let results: [GameItem]
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let gamesResponseDescription: String?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gamesResponseDescription = "description"
        case nofollowCollections = "nofollow_collections"
    }
}
extension GamesResponse {
  func toEntity() -> GamesEntity {
    return GamesEntity(next: self.next, results: self.results.map({$0.toEntity()}))
  }
}
