//
//  HomeView.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        if presenter.loadingState {
          VStack {
            ActivityIndicator()
            Text("Loading...")
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            // Horizontal Scroll Row 1
              VStack {
                ForEach(self.presenter.movies, id: \.id) { items in
                  self.presenter.linkBuilder(for: items) {
                    VStack(alignment: .center) {
                      AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/original\(items.image)"))
                        .indicator(SDWebImageActivityIndicator.whiteLarge)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                      Text(items.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                      HStack{
                        Image("star1")
                        Text(String(format: " %.1f", items.rating))
                          .font(.title3)
                          .fontWeight(.semibold)
                          .foregroundColor(Color.white)
                      }.padding(.top, 0)
                    }
                  } // builderclosing
                } // ForEachClosing
              }
          }
        }
      }.padding(.horizontal)
      .navigationBarTitle("The Movie").frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }.onAppear {
      if self.presenter.movies.count == 0 {
        self.presenter.getMovies()
      }
    }
  }
}
