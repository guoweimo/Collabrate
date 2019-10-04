//
//  LayoutGuide.swift
//  Smarock
//
//  Created by Guowei Mo on 15/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

protocol LayoutGuide {
   var leadingAnchor: NSLayoutXAxisAnchor { get }
  
   var trailingAnchor: NSLayoutXAxisAnchor { get }
  
   var leftAnchor: NSLayoutXAxisAnchor { get }
  
   var rightAnchor: NSLayoutXAxisAnchor { get }
  
   var topAnchor: NSLayoutYAxisAnchor { get }
  
   var bottomAnchor: NSLayoutYAxisAnchor { get }
  
   var widthAnchor: NSLayoutDimension { get }
  
   var heightAnchor: NSLayoutDimension { get }
  
   var centerXAnchor: NSLayoutXAxisAnchor { get }
  
   var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutGuide {}

extension UILayoutGuide: LayoutGuide {
  var firstBaselineAnchor: NSLayoutYAxisAnchor {
    return bottomAnchor
  }
  
  var lastBaselineAnchor: NSLayoutYAxisAnchor {
    return bottomAnchor
  }
}

extension LayoutGuide {
  @discardableResult
  func constraintAgainst(_ guide: LayoutGuide, with generators: [ConstraintGenerator]) -> [NSLayoutConstraint] {
    let contraints = generators.map { $0.makeConstraint(between: self, and: guide) }
    NSLayoutConstraint.activate(contraints)
    return contraints
  }
}
