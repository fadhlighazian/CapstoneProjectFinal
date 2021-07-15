//
//  FavoritePresenter.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 15/07/21.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var favorite: [FavoriteModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavorite() {
    loadingState = true
    favoriteUseCase.getFavorite()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { favorite in
        self.favorite = favorite
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(for favorite: FavoriteModel, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeDetailView(for: favorite)) {
      content()
    }
  }
}
