//
//  ContentView.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
    var body: some View {
      TabView {
        HomeView(presenter: homePresenter)
          .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
          }
        FavoriteView(presenter: favoritePresenter)
          .tabItem {
            Image(systemName: "star.fill")
            Text("Favorite")
          }
        ProfileView()
          .tabItem {
            Image(systemName: "person.crop.circle.fill")
            Text("Profile")
          }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
