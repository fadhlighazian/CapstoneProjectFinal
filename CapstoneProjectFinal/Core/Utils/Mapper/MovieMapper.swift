//
//  MovieMapper.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation

final class MovieMapper {
  static func mapMovieResponsesToDomains(
    input movieResponses: [Movie]
  ) -> [MovieModel] {

    return movieResponses.map { result in
      return MovieModel(
        id: result.id ?? 0,
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow",
        releaseDate: result.releaseDate ?? "Unknow",
        rating: result.rating ?? 0
      )
    }
  }
  
  static func mapMovieResponsesToEntities(
    input movieResponses: [Movie]
  ) -> [MovieEntity] {
    return movieResponses.map { result in
      let newMovie = MovieEntity()
      newMovie.id = result.id ?? 0
      newMovie.title = result.title ?? "Unknow"
      newMovie.image = result.image ?? "Unknow"
      newMovie.releaseDate = result.releaseDate ?? "Unknown"
      newMovie.rating = result.rating ?? 0
      return newMovie
    }
  }
   
  static func mapMovieEntitiesToDomains(
    input movieEntities: [MovieEntity]
  ) -> [MovieModel] {
    return movieEntities.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        image: result.image,
        releaseDate: result.releaseDate,
        rating: result.rating
      )
    }
  }
}

final class MovieDetailMapper {
  // Response -> Model
  static func mapMovieResponseToDomains(input movieResponses: MovieDetail) -> MovieDetailModel {
    return MovieDetailModel(
      id: movieResponses.id ?? 0,
      title: movieResponses.title ?? "Unknown",
      image: movieResponses.image ?? "Unknown",
      overview: movieResponses.overview ?? "Unknown",
      backdrop: movieResponses.backdrop ?? "Unknown",
      releaseDate: movieResponses.releaseDate ?? "Unknown",
      popularity: movieResponses.popularity ?? 0,
      rating: movieResponses.rating ?? 0,
      ratingCount: movieResponses.ratingCount ?? 0,
      genres: movieResponses.genres,
      languages: movieResponses.languages,
      companies: movieResponses.companies,
      countries: movieResponses.countries
    )
  }
}

final class FavoriteMapper {
  // Entity -> Model
  static func mapMovieEntitiesToDomains(input movieEntities: [FavoriteEntity]) -> [FavoriteModel] {
    return movieEntities.map { result in
      return FavoriteModel(
        id: result.id,
        title: result.title,
        image: result.image,
        releaseDate: result.releaseDate,
        rating: result.rating
      )
    }
  }
}

