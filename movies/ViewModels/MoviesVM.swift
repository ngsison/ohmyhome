//
//  MoviesVM.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 04/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

class MoviesVM: BaseVM {
  
  // MARK: - Public Props
  
  public var searchResult: SearchResult = SearchResult()
  public var movies: [Movie] = [Movie]()
  
  // MARK: - Public Methods
  
  /**
   Performs search against the API.
   
   - Parameter movieTitle: The value that will be passed to the `query` url parameter.
   - Parameter page: The next page that will be queried against the API.
   */
  
  public func search(_ movieTitle: String, page: Int) {
    self.showLoading()
    
    self.adapter
      .search(query: movieTitle, page: page)
      .subscribe(onNext: { searchResult in
        if searchResult.movies.isEmpty {
          self.hasError("No more movies found.")
          return
        }
        
        self.searchResult = searchResult
        self.movies = self.movies + self.searchResult.movies
        
        self.success()
      }, onError: { error in
        self.hasError("Something went wrong.")
      }).disposed(by: self.disposeBag)
  }
}
