//
//  SearchResult.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import SwiftyJSON

class Movie {
  public var posterPath: String
  public var adult: Bool
  public var overview: String
  public var releaseDate: String
  public var genreIds: [Int]
  public var id: Int
  public var originalTitle: String
  public var originalLanguage: String
  public var title: String
  public var backdropPath: String
  public var popularity: Double
  public var voteCount: Int
  public var video: Bool
  public var voteAverage: Float
  
  init?(json: JSON) {
    self.posterPath = json["poster_path"].stringValue
    self.adult = json["adult"].boolValue
    self.overview = json["overview"].stringValue
    self.releaseDate = json["release_date"].stringValue
    
    if let genreIds = json["genre_ids"].arrayObject as? [Int] {
      self.genreIds = genreIds
    } else {
      self.genreIds = [Int]()
    }
    
    self.id = json["id"].intValue
    self.originalTitle = json["original_title"].stringValue
    self.originalLanguage = json["original_language"].stringValue
    self.title = json["title"].stringValue
    self.backdropPath = json["backdrop_path"].stringValue
    self.popularity = json["popularity"].doubleValue
    self.voteCount = json["vote_count"].intValue
    self.video = json["video"].boolValue
    self.voteAverage = json["vote_average"].floatValue
  }
}

class SearchResult {
  public var movies: [Movie]
  
  init?(json: JSON) {
    if let movies = json.arrayObject as? [Movie] {
      self.movies = movies
    } else {
      self.movies = [Movie]()
    }
  }
}
