//
//  MovieEntity.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var rating: Double = 0
  
  override static func primaryKey() -> String? {
    return "id"
  }
}

class FavoriteEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var rating: Double = 0
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
