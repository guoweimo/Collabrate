//
//  UIView+AutoLayout.swift
//  Smarock
//
//  Created by Guowei Mo on 15/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

extension UIView {
  enum EdgeAnchorType: String {
    case top
    case bottom
    case leading
    case trailing
  }
}

extension UIView {
  @discardableResult
  func addAutoLayoutSubview(_ view: UIView, constraining generators: [ConstraintGenerator] = []) -> [NSLayoutConstraint] {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
    return constraintAgainst(view, with: generators)
  }
  
  @discardableResult
  func addFillingSubview(_ view: UIView) -> [NSLayoutConstraint] {
    return addAutoLayoutSubview(view, constraining: [
      .equal(\.leadingAnchor),
      .equal(\.trailingAnchor),
      .equal(\.topAnchor),
      .equal(\.bottomAnchor),
      ])
  }
  
  func addLayoutGuidedSubview(layoutGuide: LayoutGuide, subview view: UIView) {
     addAutoLayoutSubview(view)
     view.constraintAgainst(layoutGuide, with: [
      .equal(\.leadingAnchor),
      .equal(\.trailingAnchor),
      .equal(\.topAnchor),
      .equal(\.bottomAnchor),
      ])
  }
    
    func addLayoutGuidedSubview(_ view: UIView) {
        addLayoutGuidedSubview(layoutGuide: layoutMarginsGuide, subview: view)
    }

    
    func addReadableContentGuidedSubview(_ view: UIView) {
        addAutoLayoutSubview(view)
        view.constraintAgainst(readableContentGuide, with: [
            .equal(\.leadingAnchor),
            .equal(\.trailingAnchor),
            .equal(\.topAnchor),
            .equal(\.bottomAnchor),
            ])
    }

  
  @discardableResult
  func addVerticalCenterSubview(_ view: UIView, leading: CGFloat = 0, trailing: CGFloat = 0) -> [NSLayoutConstraint] {
    return addAutoLayoutSubview(view, constraining: [
      .equal(\.centerYAnchor),
      .equal(\.leadingAnchor, constant: -leading),
      .equal(\.trailingAnchor, constant: trailing)
      ])
  }
  
  @discardableResult
  func addHorizontalCenterSubview(_ view: UIView, top: CGFloat = 0, bottom: CGFloat = 0) -> [NSLayoutConstraint] {
    return addAutoLayoutSubview(view, constraining: [
      .equal(\.centerXAnchor),
      .equal(\.topAnchor, constant: top),
      .equal(\.bottomAnchor, constant: -bottom)
      ])
  }
}

extension UILayoutPriority {
  static let almostRequired = UILayoutPriority(rawValue: 950)
}

extension CGFloat {
  static let standardEdgeMargin = 40
}
