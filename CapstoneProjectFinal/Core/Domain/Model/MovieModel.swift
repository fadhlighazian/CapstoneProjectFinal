//
//  MovieModel.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Combine

struct MovieModel: Equatable, Identifiable, Hashable {
  let id: Int
  let title: String
  let image: String
  let releaseDate: String
  let rating: Double
}

struct FavoriteModel: Equatable, Identifiable, Hashable {
  let id: Int
  let title: String
  let image: String
  let releaseDate: String
  let rating: Double
}

struct MovieDetailModel: Equatable, Identifiable, Hashable {
  let id: Int
  let title: String
  let image: String
  let overview: String
  let backdrop: String
  let releaseDate: String
  let popularity: Double
  let rating: Double
  let ratingCount: Int64
  let genres: [Genres]
  let languages: [Languages]
  let companies: [Companies]
  let countries: [Countries]
}

