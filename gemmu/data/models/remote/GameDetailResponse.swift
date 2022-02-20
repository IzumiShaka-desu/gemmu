//
//  GameDetailResponse.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import Foundation
struct GameDetailResponse: Codable {
  let id: Int
  let slug, name, nameOriginal, gameDetailResponseDescription: String
  let metacritic: Int
  let released: String
  let tba: Bool
  let updated: String
  let backgroundImage, backgroundImageAdditional: String
  let website: String
  let rating: Double
  let ratingTop: Int
  let ratings: [Rating]
  let reactions: [String: Int]
  let added: Int
  let addedByStatus: AddedByStatus
  let playtime, screenshotsCount, moviesCount, creatorsCount: Int
  let achievementsCount, parentAchievementsCount: Int
  let redditURL: String
  let redditName, redditDescription: String
  let redditLogo: String
  let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int
  let ratingsCount, suggestionsCount: Int
  let metacriticURL: String
  let parentsCount, additionsCount, gameSeriesCount: Int
  let reviewsCount: Int
  let saturatedColor, dominantColor: String
  let parentPlatforms: [ParentPlatform]
  let platforms: [PlatformElement]
  let stores: [Store]
  let genres, tags: [Genre]
  let developers, publishers: [Developer]
  let esrbRating: EsrbRating
  let descriptionRaw: String
  
  enum CodingKeys: String, CodingKey {
    case id, slug, name
    case nameOriginal = "name_original"
    case gameDetailResponseDescription = "description"
    case metacritic
    case released, tba, updated
    case backgroundImage = "background_image"
    case backgroundImageAdditional = "background_image_additional"
    case website, rating
    case ratingTop = "rating_top"
    case ratings, reactions, added
    case addedByStatus = "added_by_status"
    case playtime
    case screenshotsCount = "screenshots_count"
    case moviesCount = "movies_count"
    case creatorsCount = "creators_count"
    case achievementsCount = "achievements_count"
    case parentAchievementsCount = "parent_achievements_count"
    case redditURL = "reddit_url"
    case redditName = "reddit_name"
    case redditDescription = "reddit_description"
    case redditLogo = "reddit_logo"
    case redditCount = "reddit_count"
    case twitchCount = "twitch_count"
    case youtubeCount = "youtube_count"
    case reviewsTextCount = "reviews_text_count"
    case ratingsCount = "ratings_count"
    case suggestionsCount = "suggestions_count"
    case metacriticURL = "metacritic_url"
    case parentsCount = "parents_count"
    case additionsCount = "additions_count"
    case gameSeriesCount = "game_series_count"
    case reviewsCount = "reviews_count"
    case saturatedColor = "saturated_color"
    case dominantColor = "dominant_color"
    case parentPlatforms = "parent_platforms"
    case platforms, stores, developers, genres, tags, publishers
    case esrbRating = "esrb_rating"
    case descriptionRaw = "description_raw"
  }
}
extension GameDetailResponse {
  func toEntity() -> GameDetailEntity {
    return GameDetailEntity(
      id: self.id,
      name: self.name,
      publisher: self.publishers.first?.name ?? "-",
      rating: self.rating,
      releaseDate: self.released,
      platforms: self.extractPlatformsName(),
      genres: self.extractGenreName(),
      description: self.descriptionRaw,
      imageUrl: self.backgroundImage
    )
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
