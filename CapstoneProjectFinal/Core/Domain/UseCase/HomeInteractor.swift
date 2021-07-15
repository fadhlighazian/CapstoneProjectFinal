//
//  HomeInteractor.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getMovies()
  }
}
