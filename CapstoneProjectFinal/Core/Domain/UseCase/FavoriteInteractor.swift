//
//  FavoriteInteractor.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 15/07/21.
//

import Foundation
import Combine

// Use Case
protocol FavoriteUseCase {
  func getFavorite() -> AnyPublisher<[FavoriteModel], Error>
}

// Class HomeInteractor that implement Use Case
class FavoriteInteractor: FavoriteUseCase {
  
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFavorite() -> AnyPublisher<[FavoriteModel], Error> {
    return repository.getFavorite()
  }
}
