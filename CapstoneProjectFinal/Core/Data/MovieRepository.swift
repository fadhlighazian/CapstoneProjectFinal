//
//  MovieRepository.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
  func getDetail(_ id: Int) -> AnyPublisher<MovieDetailModel, Error>
  func getFavorite() -> AnyPublisher<[FavoriteModel], Error>
  func addFavorite(_ id: Int, _ title: String, _ image: String, _ releaseDate: String, _ rating: Double)
  func deleteFavorite(_ id: Int)
  func checkExistingData(_ id: Int) -> Bool
}

final class MovieRepository: NSObject {
  typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
    return MovieRepository(locale: localeRepo, remote: remoteRepo)
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  
  func getMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.locale.getMovies()
      .flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getMovies()
            .map { MovieMapper.mapMovieResponsesToEntities(input: $0) }
            .flatMap { self.locale.addMovies(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getMovies()
              .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getDetail(_ id: Int) -> AnyPublisher<MovieDetailModel, Error> {
    return self.remote.getDetail(id)
      .map { MovieDetailMapper.mapMovieResponseToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getFavorite() -> AnyPublisher<[FavoriteModel], Error> {
    return self.locale.getFavorite()
      .map { FavoriteMapper.mapMovieEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func addFavorite(_ id: Int, _ title: String, _ image: String, _ releaseDate: String, _ rating: Double) {
    return locale.addFavorite(id, title, image, releaseDate, rating)
  }
  
  func deleteFavorite(_ id: Int) {
    return locale.deleteFavorite(id)
  }
  
  func checkExistingData(_ id: Int) -> Bool {
    return locale.checkExistingData(id)
  }
}
