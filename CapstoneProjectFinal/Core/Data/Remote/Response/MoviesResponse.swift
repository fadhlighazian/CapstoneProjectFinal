//
//  MoviesResponse.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Combine

struct MoviesResponse: Codable, Hashable {
  let results: [Movie]
}

struct Movie: Codable, Hashable {
  let id: Int?
  let title: String?
  let image: String?
  let releaseDate: String?
  let rating: Double?
  
  private enum CodingKeys: String, CodingKey {
    case id, title
    case image = "poster_path"
    case releaseDate = "release_date"
    case rating = "vote_average"
  }
}

// Detail Response
struct MovieDetail: Codable, Hashable {
  let id: Int?
  let title: String?
  let image: String?
  let overview: String?
  let backdrop: String?
  let releaseDate: String?
  let popularity: Double?
  let rating: Double?
  let ratingCount: Int64?
  
  let genres: [Genres]
  let languages: [Languages]
  let companies: [Companies]
  let countries: [Countries]
  
  private enum CodingKeys: String, CodingKey {
    case id, title, overview, popularity, genres
    case image = "poster_path"
    case backdrop = "backdrop_path"
    case releaseDate = "release_date"
    case rating = "vote_average"
    case ratingCount = "vote_count"
    case languages = "spoken_languages"
    case companies = "production_companies"
    case countries = "production_countries"
  }
}

struct Genres: Codable, Hashable {
  let nameGenre: String
  private enum CodingKeys: String, CodingKey {
    case nameGenre = "name"
  }
}

struct Languages: Codable, Hashable {
  let nameLang: String
  private enum CodingKeys: String, CodingKey {
    case nameLang = "english_name"
  }
}

struct Companies: Codable, Hashable {
  let nameComp: String
  private enum CodingKeys: String, CodingKey {
    case nameComp = "name"
  }
}

struct Countries: Codable, Hashable {
  let nameCountry: String
  private enum CodingKeys: String, CodingKey {
    case nameCountry = "name"
  }
}
