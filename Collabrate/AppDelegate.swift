//
//  AppDelegate.swift
//  Collabrate
//
//  Created by Guowei Mo on 04/10/2019.
//  Copyright © 2019 Guowei Mo. All rights reserved.
//

import UIKit
import LeanCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let configuration = LCApplication.Configuration()
    do {
      LCApplication.logLevel = .all
      try LCApplication.default.set(id: "xbX9Tii9hpchaws43KU182Cf-9Nh9j0Va",
                                    key: "c9qxvgxwy4ts0zFQtuTWgqLN",
                                    configuration: configuration)
    } catch {
      fatalError("\(error)")
    }
    return true
  }
  
}

