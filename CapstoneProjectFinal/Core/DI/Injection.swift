//
//  Injection.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

  private func provideRepository() -> MovieRepositoryProtocol {
      let realm = try? Realm()
      let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
      let remote: RemoteDataSource = RemoteDataSource.sharedInstance
      return MovieRepository.sharedInstance(locale, remote)
    }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  // Provide UseCase for FavoritePresenter
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
  
  // Provide UseCase for DetailPresenter
  func provideDetail(_ id: Int) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, id: id)
  }
}
