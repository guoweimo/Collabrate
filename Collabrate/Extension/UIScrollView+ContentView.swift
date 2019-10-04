//
//  UIScrollView.swift
//  Smarock
//
//  Created by Guowei Mo on 08/12/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

extension UIScrollView {
  func addHorizontalContentViews(_ views: [UIView]) {
    let lastView = views.reduce(nil) { ret, next -> UIView in
      addAutoLayoutSubview(next, constraining: [
        .equal(\.topAnchor),
        .equal(\.bottomAnchor)
        ])
      if let ret = ret {
        next.constraintAgainst(ret, with: [
          .equal(\.leadingAnchor, with: \.trailingAnchor)
          ])
      } else {
        addAutoLayoutSubview(next, constraining: [
          .equal(\.leadingAnchor),
          ])
      }
      next.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      next.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
      return next
    }
    if let lastView = lastView {
      constraintAgainst(lastView, with: [
        .equal(\.trailingAnchor),
        ])
    }
  }
}
