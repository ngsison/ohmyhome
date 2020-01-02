//
//  AppDelegate.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 31/12/2019.
//  Copyright © 2019 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import netfox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setUpNetfox()
    return true
  }
  
  private func setUpNetfox() {
    NFX.sharedInstance().start()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    let events = event!.allTouches
    
    let touch = events!.first
    if touch!.tapCount == 2 {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "statusBarSelected"), object: nil)
    }
  }
}

