//
//  DetailPresenter.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 01/04/21.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
  private let detailUseCase: DetailUseCase
  private var cancellables: Set<AnyCancellable> = []

  @Published var detail: MovieDetailModel?
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
  
  func getDetail() {
    detailUseCase.getDetail()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { movies in
        self.detail = movies as MovieDetailModel
      })
      .store(in: &cancellables)
  }
  
  func addFavorite(
    _ id: Int,
    _ title: String,
    _ image: String,
    _ releaseDate: String,
    _ rating: Double
  ){
    return detailUseCase.addFavorite(id, title, image, releaseDate, rating)
  }
  
  func deleteFavorite(_ id: Int) {
    return detailUseCase.deleteFavorite(id)
  }
  
  func checkExistingData() -> Bool {
    return detailUseCase.checkExistingData()
  }
  
}
