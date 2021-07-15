//
//  FavoriteView.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
   let favorite = ["image 1", "image 2", "image 3", "image 4", "image 5"]
   let genres = ["Action", "Adventure", "Fantasy"]
  @ObservedObject var presenter: FavoritePresenter
   
   var body: some View {
     NavigationView {
       ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading) {
          if presenter.loadingState {
            VStack {
              Text("Loading...")
              ActivityIndicator()
            }
          } else {
         VStack(alignment: .leading) {
          ForEach(self.presenter.favorite, id: \.id) { items in
            self.presenter.linkBuilder(for: items) {
             HStack(alignment: .top) {
              AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/original\(items.image)"))
                 .resizable()
                 .frame(width: 106, height: 159)
               VStack(alignment: .leading) {
                Text(items.title)
                   .font(.title3)
                  .foregroundColor(.white)
                   .fontWeight(.semibold)
                   .padding(.top, 3)
                Text("Released on \(items.releaseDate)")
                   .font(.body)
                   .foregroundColor(.gray)
                   .padding(.top, 3)
                  .padding(.bottom, 8)
                HStack(alignment: .bottom) {
                  switch items.rating {
                  case 0.0...2.9:
                    (Text(Image("star1")) + Text(String(format: " %.1f", items.rating))
                      .font(.system(size: 20))
                      .foregroundColor(Color.white)
                      .fontWeight(.bold)
                    )
                  case 3.0...4.9:
                    (Text(Image("star2")) + Text(String(format: " %.1f", items.rating))
                      .font(.system(size: 20))
                      .foregroundColor(Color.white)
                      .fontWeight(.bold)
                    )
                  case 5.0...6.9:
                    (Text(Image("star3")) + Text(String(format: " %.1f", items.rating))
                      .font(.system(size: 20))
                      .foregroundColor(Color.white)
                      .fontWeight(.bold)
                    )
                  case 7.0...8.9:
                    (Text(Image("star4")) + Text(String(format: " %.1f", items.rating))
                      .font(.system(size: 20))
                      .foregroundColor(Color.white)
                      .fontWeight(.bold)
                    )
                  case 9.0...10.0:
                    (Text(Image("star5")) + Text(String(format: " %.1f", items.rating))
                      .font(.system(size: 20))
                      .foregroundColor(Color.white)
                      .fontWeight(.bold)
                    )
                  default:
                    Text("")
                  }
                }
                }.padding(.bottom, 4)
               }.padding(.leading, 10) .padding(.top, 4)
          }
             }.padding(.bottom)
           } // ForEach
         } // VStack
       } // Else
       } // ScrollView
       .navigationBarTitle("Favorite Movie")
     } // NavigationView
     .onAppear {
       self.presenter.getFavorite()
     }
   }
}

//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}
