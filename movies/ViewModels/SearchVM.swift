//
//  SearchVM.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 31/12/2019.
//  Copyright © 2019 Nathaniel Brion Sison. All rights reserved.
//

import RxSwift

class SearchVM: BaseVM {
  
  public var movies: [Movie] = [Movie]()
  
  /**
   Performs search against the API.
   
   - Parameter movieTitle: The value that will be passed to the `query` url parameter.
   */
  
  public func search(_ movieTitle: String) {
    self.showLoading()
    
    self.adapter
      .search(query: movieTitle, page: 1)
      .subscribe(onNext: { searchResult in
        if searchResult.movies.isEmpty {
          self.hasError("No results found.")
          return
        }
        
        self.movies = searchResult.movies
        self.success()
      }, onError: { error in
        self.hasError("Something went wrong.")
      }).disposed(by: self.disposeBag)
  }
}
