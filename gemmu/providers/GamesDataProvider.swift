//
//  GamesDataProvider.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//

import Foundation
import Combine
import Alamofire
class GamesDataProvider {
    func fetchGames(query: String?=nil, currentTarget: String?=nil, completion: @escaping (GamesResponse?) -> Void) {

        if let currentUrl=currentTarget {
            AF.request(currentUrl, method: .get).responseDecodable(of: GamesResponse.self) {response in
                completion(response.value )
            }
        } else {
            var components = URLComponents(string: Constants.baseUrl+"/games")!
            let queryItems=[
                URLQueryItem(name: "key", value: Constants.apiKey),
                URLQueryItem(name: "page_size", value: "25")
            ]
            components.queryItems=queryItems
            AF.request(components.url!, method: .get).responseDecodable(of: GamesResponse.self) {response in
                completion(response.value)
            }
        }
    }
    func fetchDetailGame(id: Int, completion: @escaping (GameDetailResponse?) -> Void) {

            var components = URLComponents(string: Constants.baseUrl+"/games/\(id)")!
            let queryItems=[
                URLQueryItem(name: "key", value: Constants.apiKey)
            ]
            components.queryItems=queryItems
            AF.request(components.url!, method: .get).responseDecodable(of: GameDetailResponse.self) {response in
                completion(response.value)

        }
    }

    func fetchSearchGames(query: String, completion: @escaping (GamesSearchResponse?) -> Void) {
        var components = URLComponents(string: Constants.baseUrl+"/games")!
        let queryItems=[
            URLQueryItem(name: "key", value: Constants.apiKey),
            URLQueryItem(name: "page_size", value: "25"),
            URLQueryItem(name: "search", value: query)
        ]
        components.queryItems=queryItems
        AF.request(components.url!, method: .get).responseDecodable(of: GamesSearchResponse.self) {response in
            completion(response.value)
        }
    }

}
