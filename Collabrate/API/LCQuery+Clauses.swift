//
//  AVQuery+Clauses.swift
//  Smarock
//
//  Created by Guowei Mo on 15/02/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation
import LeanCloud

typealias Clause = (key: String, state: Condition, value: LCValueConvertible)

enum Condition {
  case equalTo
  case notEqualTo
  case greaterThan
  case greaterThanOrEqualTo
  case lessThan
  case lessThanOrEqualTo
  case containsIn
  case containsString
}

extension LCQuery {
  func addClauses(_ clauses: [Clause]) {
    clauses.forEach { clause in
      switch clause.state {
      case .equalTo:
        whereKey(clause.key, .equalTo(clause.value))
      case .notEqualTo:
        whereKey(clause.key, .notEqualTo(clause.value))
      case .greaterThan:
        whereKey(clause.key, .greaterThan(clause.value))
      case .greaterThanOrEqualTo:
        whereKey(clause.key, .greaterThanOrEqualTo(clause.value))
      case .lessThan:
        whereKey(clause.key, .lessThan(clause.value))
      case .lessThanOrEqualTo:
        whereKey(clause.key, .lessThanOrEqualTo(clause.value))
      case .containsString:
        guard let value = clause.value as? String else {
          return
        }
        whereKey(clause.key, .matchedSubstring(value))
      case .containsIn:
        guard let values = clause.value as? LCArrayConvertible else {
          return
        }
        whereKey(clause.key, .containedIn(values))
      }
    }
  }
}
