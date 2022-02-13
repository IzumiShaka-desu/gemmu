//
//  ParentPlatform.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformSpesific
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}
