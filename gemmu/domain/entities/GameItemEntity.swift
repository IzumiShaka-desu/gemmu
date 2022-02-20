//
//  GameItemEntity.swift
//  Gemmu
//
//  Created by Akashaka on 15/02/22.
//
struct GameItemEntity: Equatable, Identifiable {
  let id: Int
  let name: String
  let imageUrl: String
  let released: String
  let genres: [String]
}
