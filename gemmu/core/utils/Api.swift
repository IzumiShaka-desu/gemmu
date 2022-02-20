//
//  Api.swift
//  Gemmu
//
//  Created by Akashaka on 15/02/22.
//
import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/"
  static let apiKey = "989d0c911352450dbb8d51a2e9db86cc"
  static let defaultPageSize = "25"
  static func buildUrl(
    endpoint: Endpoints.Gets,
    param: String="",
    args: [String: String?] = [:] ) -> URL? {
    var components = URLComponents(string: endpoint.url+param)!
    var  urlArgs=[
      URLQueryItem(name: "key", value: self.apiKey),
      URLQueryItem(name: "page_size", value: self.defaultPageSize)
  ]
    for (argKey, argVal) in args {
      urlArgs.append(URLQueryItem(name: argKey, value: argVal))
    }
    components.queryItems=urlArgs
    return components.url
  }
}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  enum Gets: Endpoint {
    case games
//    case search
    public var url: String {
      switch self {
//      case .categories: return "\(API.baseUrl)categories.php"
      case .games: return "\(API.baseUrl)games"
//      case .meal: return "\(API.baseUrl)lookup.php?i="
//      case .search: return "\(API.baseUrl)games.php?s="
      }
    }
  }
}
