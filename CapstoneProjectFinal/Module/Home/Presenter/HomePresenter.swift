//
//  HomePresenter.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getMovies() {
    loadingState = true
    homeUseCase.getMovies()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { movies in
        self.movies = movies
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(for movie: MovieModel, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) {
      content()
    }
  }
}
