//
//  UITableViews+Methods.swift
//  Smarock
//
//  Created by Guowei Mo on 30/09/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  
  func register(Cell: TypedTableViewCell.Type) {
    register(Cell.self, forCellReuseIdentifier: Cell.identifier)
  }
  
  func dequeue<Cell: TypedTableViewCell>(at indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
      fatalError("unexpected cell type")
    }
    return cell
  }
}

extension UITableViewCell: TypedTableViewCell {
  
}

protocol TypedTableViewCell: class {
  static var identifier: String { get }
}

extension TypedTableViewCell {
  static var identifier: String {
    return String(describing: Self.self)
  }
}
