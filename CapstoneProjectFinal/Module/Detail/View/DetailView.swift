//
//  DetailView.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 01/04/21.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter
  @State var showsAlert = false
  @State var isClicked = false
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      if let detail = self.presenter.detail{
        VStack(alignment: .leading) {
          AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(detail.backdrop)"))
            .indicator(SDWebImageActivityIndicator.whiteLarge)
            .resizable()
            .scaledToFill()
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.bottom)
          // Top Section
          HStack(alignment: .top) {
            AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(detail.image)"))
              .indicator(SDWebImageActivityIndicator.whiteLarge)
              .resizable()
              .frame(width: 106, height: 159)
              .scaledToFit()
              .cornerRadius(10)
              .shadow(radius: 5)
          VStack(alignment: .leading) {
            Text(detail.title)
              .font(.title2)
              .fontWeight(.bold)
              .padding(.bottom, 2)
            HStack(alignment: .bottom) {
              switch detail.rating {
              case 0.0...2.9:
                (Text(Image("star1")) + Text(String(format: " %.1f", detail.rating))
                  .font(.system(size: 20))
                  .foregroundColor(Color.white)
                  .fontWeight(.bold)
                )
              case 3.0...4.9:
                (Text(Image("star2")) + Text(String(format: " %.1f", detail.rating))
                  .font(.system(size: 20))
                  .foregroundColor(Color.white)
                  .fontWeight(.bold)
                )
              case 5.0...6.9:
                (Text(Image("star3")) + Text(String(format: " %.1f", detail.rating))
                  .font(.system(size: 20))
                  .foregroundColor(Color.white)
                  .fontWeight(.bold)
                )
              case 7.0...8.9:
                (Text(Image("star4")) + Text(String(format: " %.1f", detail.rating))
                  .font(.system(size: 20))
                  .foregroundColor(Color.white)
                  .fontWeight(.bold)
                )
              case 9.0...10.0:
                (Text(Image("star5")) + Text(String(format: " %.1f", detail.rating))
                  .font(.system(size: 20))
                  .foregroundColor(Color.white)
                  .fontWeight(.bold)
                )
              default:
                Text("")
              }
            }.padding(.bottom, 4)
            Text("Released on \(detail.releaseDate)")
              .foregroundColor(.gray)
              .font(.system(size: 14))
              .fontWeight(.regular)
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(detail.genres, id: \.self) { items in
                  Text(items.nameGenre)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                }
              }
            }
            HStack {
              if !isClicked {
                Button(action: {
                  self.presenter.addFavorite(detail.id, detail.title, detail.image, detail.releaseDate, detail.rating)
                  DispatchQueue.main.async {
                    isClicked = true
                    self.showsAlert.toggle()
                  }
                }) {
                  Text("Add To Favorite")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.all, 7)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color(.red))
                .cornerRadius(5)
              } else {
                Button(action: {
                  self.presenter.deleteFavorite(detail.id)
                  DispatchQueue.main.async {
                    isClicked = false
                  }
                }) {
                  Text("Has been added to favorite")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.all, 7)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color(.systemGray2))
                .cornerRadius(5)
              }
            } // HStack Closing button
          }.padding(.leading, 10)
          }
      
          // Sinopsis Section
          VStack(alignment: .leading) {
            Text("Overview")
              .fontWeight(.bold)
              .titleStyle()
            Text(detail.overview)
              .font(.body)
              .foregroundColor(.gray)
          }
          // Languages Section
            Text("Languages")
              .fontWeight(.bold)
              .titleStyle()
            ScrollView(.vertical, showsIndicators: false) {
              VStack(alignment: .leading) {
                ForEach(detail.languages, id: \.self) { items in
                  Text(items.nameLang)
                    .foregroundColor(.gray)
                }
              }
            }
          // Companies Section
            Text("Companies")
              .fontWeight(.bold)
              .titleStyle()
            ScrollView(.vertical, showsIndicators: false) {
              VStack(alignment: .leading) {
                ForEach(detail.companies, id: \.self) { items in
                  Text(items.nameComp)
                    .foregroundColor(.gray)
                }
              }
            }
          // Production Countries Section
            Text("Production Countries")
              .fontWeight(.bold)
              .titleStyle()
            ScrollView(.vertical, showsIndicators: false) {
              VStack(alignment: .leading) {
                ForEach(detail.countries, id: \.self) { items in
                  Text(items.nameCountry)
                    .foregroundColor(.gray)
                }
              }
            }
        }
      } else {
        Text("There is no content.")
          .font(.system(size: 22))
          .foregroundColor(Color.white)
          .fontWeight(.bold)
      }
    }.padding(.horizontal)
    .navigationBarTitle("Detail Movie")
    .alert(isPresented: $showsAlert) {
      Alert(title: Text("Success!"), message: Text("\"\(self.presenter.detail!.title)\" has been added to favorite"), dismissButton: .default(Text("OK")))
    }
    .onAppear(){
      presenter.getDetail()
      let data = presenter.checkExistingData()
      if data == true {
        isClicked = true
      } else {
        isClicked = false
      }
    }
  }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//      DetailView(presenter: DetailPresenter)
//    }
//}

extension View {
  func titleStyle() -> some View {
    self.modifier(GeneralTitle())
  }
}

struct GeneralTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title2)
      .padding(.top)
      .padding(.bottom, 4)
  }
}
