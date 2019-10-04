//
//  UIApplication+StatusBar.swift
//  Smarock
//
//  Created by Guowei Mo on 08/01/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import UIKit

extension UIApplication {
  var statusBarView: UIView? {
    if #available(iOS 13.0, *) {
        let tag = 38482458385
        if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
            statusBar.tag = tag
            UIApplication.shared.keyWindow?.addSubview(statusBar)
            return statusBar
        }
    } else {
        return UIApplication.shared.value(forKey: "statusBar") as? UIView
    }
  }
}
