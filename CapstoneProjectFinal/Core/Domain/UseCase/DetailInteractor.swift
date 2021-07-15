//
//  DetailInteractor.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 01/04/21.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getDetail() -> AnyPublisher<MovieDetailModel, Error>
  func addFavorite(_ id: Int, _ title: String, _ image: String, _ releaseDate: String, _ rating: Double)
  func deleteFavorite(_ id: Int)
  func checkExistingData() -> Bool
}

class DetailInteractor: DetailUseCase {

  private let repository: MovieRepositoryProtocol
  private let id: Int

  required init(repository: MovieRepositoryProtocol, id: Int) {
    self.repository = repository
    self.id = id
  }

  func getDetail() -> AnyPublisher<MovieDetailModel, Error> {
    return repository.getDetail(id)
  }
  
  func addFavorite(_ id: Int, _ title: String, _ image: String, _ releaseDate: String, _ rating: Double) {
    return repository.addFavorite(id, title, image, releaseDate, rating)
  }
  
  func deleteFavorite(_ id: Int) {
    return repository.deleteFavorite(id)
  }
  
  func checkExistingData() -> Bool {
    return repository.checkExistingData(id)
  }

}
