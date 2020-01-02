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
    
    self.setUpNetfox()
    return true
  }
  
  /**
   Observe for double tap to trigger netfox.
   */
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    let touchEvents = event!.allTouches
    
    let latestTouchEvent = touchEvents!.first
    
    if latestTouchEvent!.tapCount == 2 {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showNetfox"), object: nil)
    }
  }
  
  /**
   Start netfox service.
   */
  
  private func setUpNetfox() {
    NFX.sharedInstance().start()
  }
}

