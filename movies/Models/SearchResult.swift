//
//  SearchResult.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import SwiftyJSON

class SearchResult {
  
  public var totalPages = 0
  public var totalResults = 0
  public var page = 0
  public var movies: [Movie] = [Movie]()
  
  init() {}
  
  init?(json: JSON) {
    guard let result = json["results"].array else {
      return nil
    }
    
    self.totalPages = json["total_pages"].intValue
    self.totalResults = json["total_results"].intValue
    self.page = json["page"].intValue
    
    self.movies = [Movie]()
    for movieJson in result {
      if let movie = Movie(json: movieJson) {
        self.movies.append(movie)
      }
    }
  }
}
