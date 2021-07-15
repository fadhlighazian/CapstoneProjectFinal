//
//  HomeRouter.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 01/04/21.
//

import SwiftUI

class HomeRouter {
  func makeDetailView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie.id)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
