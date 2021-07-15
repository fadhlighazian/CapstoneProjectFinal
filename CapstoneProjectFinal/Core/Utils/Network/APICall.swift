//
//  APICall.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation

struct API {
  static let baseUrl = "https://api.themoviedb.org/3/movie/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case movies
    case detail
    
    public var url: String {
      switch self {
      case .movies: return "\(API.baseUrl)now_playing?api_key=02b26526598c878b02d249743e3f3373&language=en-US&page=1"
      case .detail: return "\(API.baseUrl)"
      }
    }
  }
}
