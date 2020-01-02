//
//  ActivityIndicator.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ActivityIndicatorType {
  func startAnimating()
  func stopAnimating()
}

class ActivityIndicator: ActivityIndicatorType {
  
  public static let shared = ActivityIndicator()
  
  private var activityIndicator: ActivityData {
    return ActivityData(
      size: CGSize(width: 60, height: 60),
      message: "",
      messageFont: UIFont.italicSystemFont(ofSize: 16),
      messageSpacing: 8,
      type: .ballPulseSync,
      color: .white,
      padding: 0,
      displayTimeThreshold: 0,
      minimumDisplayTime: 0,
      backgroundColor: UIColor.init(white: 0, alpha: 0.6),
      textColor: .white
    )
  }
  
  public func startAnimating() {
    if !NVActivityIndicatorPresenter.sharedInstance.isAnimating {
      NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityIndicator, nil)
    }
  }
  
  public func stopAnimating() {
    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
  }
}

