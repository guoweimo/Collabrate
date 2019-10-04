//
//  UIButton+Localization.swift
//  Smarock
//
//  Created by Guowei Mo on 16/08/2018.
//  Copyright © 2018 Smarock. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIButton {
  
  func setTitle(_ text: String) {
    setTitle(text, for: .normal)
  }
  
  func setImage(_ image: UIImage) {
    setImage(image, for: .normal)
  }
}

extension UIButton {
  func toggleWhenTapped(between title1: String, image1: UIImage? = nil, and title2: String, image2: UIImage? = nil) {
    rx.tap.bind {
      if self.currentTitle == title1 {
        self.setTitle(title2)
        if let image2 = image2 {
          self.setImage(image2, for: .normal)
        }
      } else if self.currentTitle == title2 {
        self.setTitle(title1)
        if let image1 = image1 {
          self.setImage(image1, for: .normal)
        }
      }
    }
  }
}
