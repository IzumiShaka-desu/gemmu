//
//  SearchItemResultEntity.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

struct SearchItemResultEntity: Equatable, Identifiable {
  let id: Int
  let name: String
  let imageUrl: String
  let released: String
  let genres: [String]
}
