
//
//  Array+Vars.swift
//  Smarock
//
//  Created by Guowei Mo on 14/07/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation

extension Array {
  static var empty: [Element] {
    return .init()
  }
  
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
  
  @discardableResult
  mutating func removeLastSafely() -> Element? {
    guard !self.isEmpty else {
      return nil
    }
    return removeLast()
  }
}
