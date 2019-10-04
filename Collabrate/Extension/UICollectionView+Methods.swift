//
//  UITableViews+Methods.swift
//  Smarock
//
//  Created by Guowei Mo on 30/09/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
  
  func register(Cell: TypedCollectionViewCell.Type) {
    register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
  }
  
  func dequeue<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
      fatalError("unexpected cell type")
    }
    return cell
  }
}

extension UICollectionViewCell: TypedCollectionViewCell {
  
}

protocol TypedCollectionViewCell: class {
  static var identifier: String { get }
}

extension TypedCollectionViewCell {
  static var identifier: String {
    return String(describing: Self.self)
  }
}
