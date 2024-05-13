//
//  ViewControllerPreview.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
  
  var viewControllerBuilder: () -> UIViewController
  
  init(_ viewControllerBuilder: @escaping () -> UIViewController) {
    self.viewControllerBuilder = viewControllerBuilder
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    viewControllerBuilder()
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

  }
 
}
