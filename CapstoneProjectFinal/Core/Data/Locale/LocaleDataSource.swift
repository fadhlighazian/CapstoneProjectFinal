//
//  LocaleDataSource.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
  func getMovies() -> AnyPublisher<[MovieEntity], Error>
  func addMovies(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error>
  func getFavorite() -> AnyPublisher<[FavoriteEntity], Error>
  func addFavorite(_ id: Int, _ title: String, _ image: String, _ releaseDate: String, _ rating: Double)
  func deleteFavorite(_ id: Int)
  func checkExistingData(_ id: Int) -> Bool
}

final class LocaleDataSource: NSObject {
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  // getMovies
  func getMovies() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  // addMovies
  func addMovies(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for movie in movies {
              realm.add(movie, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  // getFavorite
  func getFavorite() -> AnyPublisher<[FavoriteEntity], Error> {
    return Future<[FavoriteEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<FavoriteEntity> = {
          realm.objects(FavoriteEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: FavoriteEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
    
  // addFavorite
  func addFavorite(_ id: Int, _ title: String, _ image: String, _ releaseDate: String, _ rating: Double) {
    let config = Realm.Configuration(schemaVersion: 1)
    do {
      let realm = try Realm(configuration: config)
      let newData = FavoriteEntity()
      newData.id = id
      newData.title = title
      newData.image = image
      newData.releaseDate = releaseDate
      newData.rating = rating
      try realm.write({
        realm.add(newData)
        print("Add")
      })
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // deleteFavorite
  func deleteFavorite(_ id: Int) {
    let config = Realm.Configuration(schemaVersion: 1)
    do {
      let realm = try Realm(configuration: config)
      let result = realm.objects(FavoriteEntity.self)
      for item in result {
        try realm.write({
          if item.id == id {
            realm.delete(item)
            print("delete")
          }
        })
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // checkExistingData
  func checkExistingData(_ id: Int) -> Bool {
    let config = Realm.Configuration(schemaVersion: 1)
    var flag: Bool = false
    do {
      let realm = try Realm(configuration: config)
      let result = realm.objects(FavoriteEntity.self)
      for item in result {
          if item.id == id {
            flag = true
          }
      }
    } catch {
      print(error.localizedDescription)
    }
    return flag
  }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
