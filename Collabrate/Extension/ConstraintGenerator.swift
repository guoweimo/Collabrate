//
//  ConstraintGenerator.swift
//  Smarock
//
//  Created by Guowei Mo on 15/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

struct ConstraintGenerator {
  var generate: (LayoutGuide, LayoutGuide) -> NSLayoutConstraint
  
  func makeConstraint(between guide1: LayoutGuide, and guide2: LayoutGuide) -> NSLayoutConstraint {
    return generate(guide1, guide2)
  }
}

extension ConstraintGenerator {
  static func equal<AnchorType, Concrete>(_ anchorPath: KeyPath<LayoutGuide, Concrete>,
                                          with otherPath: KeyPath<LayoutGuide, Concrete>? = nil,
                                          constant: CGFloat = 0,
                                          priority: UILayoutPriority = .required) -> ConstraintGenerator where Concrete: NSLayoutAnchor<AnchorType> {
    return ConstraintGenerator { guide1, guide2 in
      let resolvedOtherPath = otherPath ?? anchorPath
      let constraint = guide1[keyPath: anchorPath].constraint(equalTo: guide2[keyPath: resolvedOtherPath], constant: constant)
      constraint.priority = priority
      return constraint
    }
  }
  
  static func greaterThanOrEqual<AnchorType, Concrete>(_ anchorPath: KeyPath<LayoutGuide, Concrete>,
                                                       with otherPath: KeyPath<LayoutGuide, Concrete>? = nil,
                                                       constant: CGFloat = 0,
                                                       priority: UILayoutPriority = .required) -> ConstraintGenerator where Concrete: NSLayoutAnchor<AnchorType> {
    return ConstraintGenerator { guide1, guide2 in
      let resolvedOtherPath = otherPath ?? anchorPath
      let constraint = guide1[keyPath: anchorPath].constraint(greaterThanOrEqualTo: guide2[keyPath: resolvedOtherPath], constant: constant)
      constraint.priority = priority
      return constraint
    }
  }
  
  static func lessThanOrEqual<AnchorType, Concrete>(_ anchorPath: KeyPath<LayoutGuide, Concrete>,
                                                    with otherPath: KeyPath<LayoutGuide, Concrete>? = nil,
                                                    constant: CGFloat = 0,
                                                    priority: UILayoutPriority = .required) -> ConstraintGenerator where Concrete: NSLayoutAnchor<AnchorType> {
    return ConstraintGenerator { guide1, guide2 in
      let resolvedOtherPath = otherPath ?? anchorPath
      let constraint = guide1[keyPath: anchorPath].constraint(lessThanOrEqualTo: guide2[keyPath: resolvedOtherPath], constant: constant)
      constraint.priority = priority
      return constraint
    }
  }
}
