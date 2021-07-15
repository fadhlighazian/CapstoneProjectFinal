//
//  FavoriteRouter.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 15/07/21.
//

import SwiftUI

class FavoriteRouter {
  func makeDetailView(for movie: FavoriteModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie.id)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
