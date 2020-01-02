//
//  SearchResult.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import SwiftyJSON

class SearchResult {
  public var movies: [Movie]
  
  init?(json: JSON) {
    guard let result = json["result"].array else {
      return nil
    }
    
    self.movies = [Movie]()
    
    for movieJson in result {
      if let movie = Movie(json: movieJson) {
        self.movies.append(movie)
      }
    }
  }
}
