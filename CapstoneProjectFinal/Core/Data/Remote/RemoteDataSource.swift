//
//  RemoteDataSource.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
  func getMovies() -> AnyPublisher<[Movie], Error>
  func getDetail(_ id: Int) -> AnyPublisher<MovieDetail, Error>
}

final class RemoteDataSource: NSObject {
  let apiKey = "02b26526598c878b02d249743e3f3373"
  let language = "en-US"
  let page = "1"
  
  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getMovies() -> AnyPublisher<[Movie], Error> {
    return Future<[Movie], Error> { completion in
      if let url = URL(string: Endpoints.Gets.movies.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetail(_ id: Int) -> AnyPublisher<MovieDetail, Error> {
    guard var components = URLComponents(string: "\(Endpoints.Gets.detail.url)\(id)") else { return URLError.invalidResponse as! AnyPublisher<MovieDetail, Error> }
    components.queryItems = [
      URLQueryItem(name: "api_key", value: apiKey),
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "page", value: page)
    ]
    let request = URLRequest(url: components.url!)
    
    return Future<MovieDetail, Error> { completion in
      if let url = URL(string: "\(request)") {
        print(url)
        AF.request(url)
          .validate()
          .responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
