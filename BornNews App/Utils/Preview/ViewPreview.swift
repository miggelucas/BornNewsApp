//
//  ViewPreview.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation
import SwiftUI

struct ViewPreview: UIViewRepresentable {
  
  var viewBuilder: () -> UIView
  
  init(_ viewControllerBuilder: @escaping () -> UIView) {
    self.viewBuilder = viewControllerBuilder
  }
  
  func makeUIView(context: Context) -> some UIView {
    viewBuilder()
  }
  
  func updateUIView(_ uiViewController: UIViewType, context: Context) {
      
  }
}
