//
//  String+Substring.swift
//  Smarock
//
//  Created by Guowei Mo on 26/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import Foundation

import Foundation

extension String {
  subscript(value: NSRange) -> Substring {
    return self[value.lowerBound..<value.upperBound]
  }
}

extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    return self[index(at: value.lowerBound)...index(at: value.upperBound)]
  }
  
  subscript(value: CountableRange<Int>) -> Substring {
    return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
  }
  
  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    return self[..<index(at: value.upperBound)]
  }
  
  subscript(value: PartialRangeThrough<Int>) -> Substring {
    return self[...index(at: value.upperBound)]
  }
  
  subscript(value: PartialRangeFrom<Int>) -> Substring {
    return self[index(at: value.lowerBound)...]
  }
  
  func index(at offset: Int) -> String.Index {
    return index(startIndex, offsetBy: offset)
  }
}

extension String {
  func matches(_ regex: String) -> Bool {
    return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }
}

extension String {
  func numberToUpperCharacter() -> String {
    let idx = String(UnicodeScalar("A").value + UInt32(self)! - 1)
    return String(UnicodeScalar(Int(idx)!)!)
  }
}

extension Array where Element: StringProtocol {
  func joinedAnswers() -> String {
    return joined(separator: "; ")
  }
}

extension String {
    func containsIgnoringCase(_ string: String) -> Bool {
        return lowercased().contains(string.lowercased())
    }
}
