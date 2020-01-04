//
//  SearchAPI.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import Moya

enum SearchAPI {
  case search(query: String, page: Int)
}

extension SearchAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }
  
  var path: String {
    switch self {
    case .search:
      return "/search/movie"
    }
  }
  
  var method: Method {
    switch self {
    case .search:
      return .get
    }
  }
  
  var sampleData: Data {
    switch self {
    case .search:
      return stubbedResponse("searchResponse")
    }
  }
  
  var task: Task {
    switch self {
    case .search(let query, let page):
      return .requestParameters(parameters: ["api_key": Constants.API_KEY, "query": query, "page": page],
                                encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}
