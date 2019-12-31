//
//  SearchVC.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 31/12/2019.
//  Copyright © 2019 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

  // MARK: Private Props
  
  private let viewModel = SearchVM()
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var searchBarTextField: UITextField!
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - IBActions

  @IBAction func didTapSearch(_ sender: Any) {
    self.search()
  }
  
  // MARK: - Private Functions
  
  private func search() {
    guard let movieTitle = searchBarTextField.text else {
      return
    }
    
    viewModel.search(movieTitle)
  }
}

