//
//  ActivityIndicator.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

  func makeUIView(
    context: UIViewRepresentableContext<ActivityIndicator>
  ) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: .large)
  }
  
  func updateUIView(
    _ uiView: UIActivityIndicatorView,
    context: UIViewRepresentableContext<ActivityIndicator>
  ) {
    uiView.startAnimating()
  }

}
