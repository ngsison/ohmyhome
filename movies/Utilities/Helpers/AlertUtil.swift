//
//  AlertUtil.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

protocol AlertType {
  func showAlert(title: String, message: String, viewController: UIViewController)
  func showAlert(title: String, message: String, viewController: UIViewController, actions: [UIAlertAction])
}

class AlertUtil: AlertType {
  
  public static let shared = AlertUtil()
  
  public func showAlert(title: String, message: String, viewController: UIViewController) {
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(okAction)
    
    viewController.present(alert, animated: true, completion: nil)
  }
  
  public func showAlert(title: String, message: String, viewController: UIViewController, actions: [UIAlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    for action in actions {
      alert.addAction(action)
    }
    
    viewController.present(alert, animated: true, completion: nil)
  }
}

