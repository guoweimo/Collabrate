//
//  Encodable.swift
//  Smarock
//
//  Created by Guowei Mo on 15/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import Foundation

extension Encodable {
  func json() -> [String: Any]? {
    do {
      let data = try JSONEncoder().encode(self)
      let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
      let json = dict as? [String: Any]
      return json
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}

struct EmptyEncodable: Encodable {
  
}
