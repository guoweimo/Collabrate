//
//  UIStackView+Config.swift
//  Smarock
//
//  Created by Guowei Mo on 16/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

extension UIStackView {
  func applyStyle(_ style: StackViewStyle = .standardVertical) {
    alignment = .center
    switch style {
    case .standardVertical:
      axis = .vertical
      spacing = 20
    case .standardHorizontal:
      axis = .horizontal
      spacing = 30
    case .customVertical(let spacing):
      axis = .vertical
      self.spacing = spacing
    case .customHorizontal(let spacing):
      axis = .horizontal
      self.spacing = spacing
    case .custom(let axis, let align, let spacing):
      self.axis = axis
      alignment = align
      self.spacing = spacing
    }
  }
}

extension UIStackView {
  func insertArrangedSubview(_ view: UIView, after aView: UIView) {
    if let index = arrangedSubviews.firstIndex(of: aView) {
      insertArrangedSubview(view, at: index + 1)
    }
  }
  
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach {
      addArrangedSubview($0)
    }
  }
  
  func removeAllSubviews() {
    arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }
  }
}

enum StackViewStyle {
  case standardVertical
  case standardHorizontal
  case customVertical(spacing: CGFloat)
  case customHorizontal(spacing: CGFloat)
  case custom(axis: NSLayoutConstraint.Axis, align: UIStackView.Alignment, spacing: CGFloat)
}
