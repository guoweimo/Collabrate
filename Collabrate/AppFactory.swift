//
//  AppFactory.swift
//  Collabrate
//
//  Created by Guowei Mo on 23/10/2019.
//  Copyright © 2019 Guowei Mo. All rights reserved.
//

import UIKit

struct AppFactory {
  
  func mainAppController() -> UITabBarController {
    let homeVC = HomeViewController()
    homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
    
    let searchVC = UIViewController()
    searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
    
    let messageVC = UIViewController()
    messageVC.tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "message"), tag: 2)

    let profileVC = UIViewController()
    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)

    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [homeVC, messageVC, profileVC]
    
    return tabBarController

  }
}
