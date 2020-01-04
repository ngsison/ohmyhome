//
//  MoviesVC.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 04/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
  
  // MARK: Public Props
  
  public var viewModel: MoviesVM = MoviesVM()
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpTableView()
  }
  
  // MARK: - Private Methods
  
  private func setUpTableView() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
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
}


