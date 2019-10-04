//
//  UIView+Animations.swift
//  Smarock
//
//  Created by Guowei Mo on 01/09/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import UIKit

extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: .linear)
    animation.duration = 0.6
    animation.values = [-10, 10, -10, 10, -5, 5, 0 ]
    layer.add(animation, forKey: "shake")
  }
}
