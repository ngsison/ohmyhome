//
//  SearchVC.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 31/12/2019.
//  Copyright © 2019 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import netfox

class SearchVC: UIViewController {

  // MARK: Private Props
  
  private let activityIndicator: ActivityIndicatorType = ActivityIndicator.shared
  private let alertUtil: AlertType = AlertUtil.shared
  private let viewModel = SearchVM()
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var searchBarTextField: UITextField!
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpRx()
    self.setUpNetfox()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - IBActions

  @IBAction func didTapSearch(_ sender: Any) {
    self.search()
  }
  
  // MARK: - Private Functions
  
  /**
   Start listening to `showNetfox` notification.
   */
  
  private func setUpNetfox() {
    let notificationName = NSNotification.Name(rawValue: "showNetfox")
    
    NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { event in
      NFX.sharedInstance().show()
    }
  }
  
  private func handleIsSuccess(_ isSuccess: Bool) {
    if isSuccess {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesVC") as! MoviesVC
      self.navigationController?.pushViewController(moviesVC, animated: true)
    }
  }
  
  private func handleIsBusy(_ isBusy: Bool) {
    if isBusy {
      self.activityIndicator.startAnimating()
    } else {
      self.activityIndicator.stopAnimating()
    }
  }
  
  private func handleErrorMessage(_ errorMessage: String) {
    self.alertUtil.showAlert(title: "Oops!", message: errorMessage, viewController: self)
  }
  
  private func setUpRx() {
    self.viewModel.isSuccess
      .asObservable()
      .subscribe(onNext: { (isSuccess) in
        self.handleIsSuccess(isSuccess)
      }).disposed(by: self.viewModel.disposeBag)
    
    self.viewModel.isBusy
      .asObservable()
      .subscribe(onNext: { (isBusy) in
        self.handleIsBusy(isBusy)
      }).disposed(by: self.viewModel.disposeBag)
    
    self.viewModel.errorMessage
      .asObservable()
      .filter { $0 != "" }
      .bind { errorMessage in
        self.handleErrorMessage(errorMessage)
      }.disposed(by: self.viewModel.disposeBag)
  }
  
  private func search() {
    guard let movieTitle = searchBarTextField.text else {
      return
    }
    
    viewModel.search(movieTitle)
  }
}

