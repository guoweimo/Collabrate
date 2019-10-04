//
//  UIViewController+Children.swift
//  Smarock
//
//  Created by Guowei Mo on 17/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

extension UIViewController {
  func replaceCurrentChild(with newChild: UIViewController) {
    guard children.count > 0 else {
      fatalError("No existing child view controller!")
    }
    children.forEach {
      $0.willMove(toParent: nil)
      $0.view.removeFromSuperview()
      $0.removeFromParent()
    }
    addChild(newChild)
    view.addFillingSubview(newChild.view)
  }
}

extension UIViewController {
  
  func presentFullScreen(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    if #available(iOS 13.0, *) {
      viewControllerToPresent.modalPresentationStyle = .fullScreen
      viewControllerToPresent.navigationController?.modalPresentationStyle = .fullScreen
      present(viewControllerToPresent, animated: flag, completion: completion)
    } else {
      present(viewControllerToPresent, animated: flag, completion: completion)
    }
  }
}
