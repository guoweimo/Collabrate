//
//  UIResponder.swift
//  Smarock
//
//  Created by Guowei Mo on 31/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import Foundation

extension UIView {
  var firstResponder: UIView? {
    guard !isFirstResponder else { return self }
    
    for subview in subviews {
      if let firstResponder = subview.firstResponder {
        return firstResponder
      }
    }
    
    return nil
  }
}
