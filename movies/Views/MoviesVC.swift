//
//  MoviesVC.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 04/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import RxSwift

class MoviesVC: UIViewController {
  
  // MARK: Public Props
  
  private let activityIndicator: ActivityIndicatorType = ActivityIndicator.shared
  private let alertUtil: AlertType = AlertUtil.shared
  public var viewModel: MoviesVM = MoviesVM()
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpTableView()
    self.setUpRx()
  }
  
  // MARK: - Private Methods
  
  private func setUpTableView() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  private func handleIsSuccess(_ isSuccess: Bool) {
    if isSuccess {
      self.tableView.reloadData()
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
}

// MARK: - UITableViewDataSource

extension MoviesVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
    cell.configure(self.viewModel.movies[indexPath.row])
    return cell
  }
}

// MARK: - UITableViewDelegate

extension MoviesVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 400
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleFrameHeight = scrollView.frame.size.height
    let invisibleContentHeight = scrollView.contentOffset.y
    
    let visibleContentHeight = scrollView.contentSize.height - invisibleContentHeight
    
    if visibleContentHeight < visibleFrameHeight {
      if !self.viewModel.isBusy.value && self.viewModel.searchResult.page < self.viewModel.searchResult.totalPages {
        let movieTitle = self.viewModel.searchKeyword
        let nextPage = self.viewModel.searchResult.page + 1
        self.viewModel.search(movieTitle, page: nextPage)
      }
    }
  }
}
