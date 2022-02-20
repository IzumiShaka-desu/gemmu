//
//  GameItem.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
struct GameItem: Codable {
  let id: Int
  let slug, name, released: String?
  let tba: Bool?
  let backgroundImage: String?
  let rating: Double?
  let ratingTop: Int?
  let ratings: [Rating]?
  let ratingsCount, reviewsTextCount, added: Int?
  let addedByStatus: AddedByStatus?
  let metacritic, playtime, suggestionsCount: Int?
  let updated: String?
  let reviewsCount: Int?
  let platforms: [PlatformElement]
  let parentPlatforms: [ParentPlatform]?
  let genres: [Genre]
  let stores: [Store]?
  let tags: [Genre]?
  let esrbRating: EsrbRating?
  let shortScreenshots: [ShortScreenshot]?
  
  enum CodingKeys: String, CodingKey {
    case id, slug, name, released, tba
    case backgroundImage = "background_image"
    case rating
    case ratingTop = "rating_top"
    case ratings
    case ratingsCount = "ratings_count"
    case reviewsTextCount = "reviews_text_count"
    case added
    case addedByStatus = "added_by_status"
    case metacritic, playtime
    case suggestionsCount = "suggestions_count"
    case updated
    case reviewsCount = "reviews_count"
    case platforms
    case parentPlatforms = "parent_platforms"
    case genres, stores, tags
    case esrbRating = "esrb_rating"
    case shortScreenshots = "short_screenshots"
  }
}
extension GameItem {
  func toEntity() -> GameItemEntity {
    return GameItemEntity(
      id: self.id,
      name: self.name ?? "",
      imageUrl: self.backgroundImage ?? "",
      released: self.released ?? "",
      genres: self.extractGenreName()
    )
  }
  func extractPlatformsImageLink() -> [String] {
    var results: [String]=[]
    for platform in self.platforms {
      results.append(platform.platform.imageBackground)
    }
    return results
  }
  func extractPlatformsName() -> [String] {
    var results: [String]=[]
    for platform in self.platforms {
      results.append(platform.platform.name)
    }
    return results
  }
  
  func extractGenreName() -> [String] {
    var results: [String]=[]
    for genre in self.genres {
      results.append(genre.name)
    }
    return results
  }
  
}
