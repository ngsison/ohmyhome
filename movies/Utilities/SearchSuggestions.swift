//
//  SearchSuggestions.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 05/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

protocol SearchSuggestionsDefinition {
  func add(_ searchKeyword: String)
  func load() -> [String]
  func clear()
}

class SearchSuggestions {
  
  // MARK: - Private Props
  
  private let storageKey: String = "suggestions"
  private let suggestionsLimit: Int = 10
 
  // MARK: - Public Props
  
  public static let shared = SearchSuggestions()

  // MARK: - Public Methods
  
  public func add(_ searchKeyword: String) {
    var suggestions = self.load()
    suggestions.insert(searchKeyword, at: 0)
    
    if suggestions.count > self.suggestionsLimit {
      let mostRecentSuggestions = suggestions[..<self.suggestionsLimit]
      UserDefaults.standard.set(Array(mostRecentSuggestions), forKey: storageKey)
    } else {
      UserDefaults.standard.set(suggestions, forKey: storageKey)
    }
  }
  
  public func load() -> [String] {
    guard let savedSuggestions = UserDefaults.standard.array(forKey: storageKey) as? [String] else {
      return [String]()
    }
    
    return savedSuggestions
  }
  
  public func clear() {
    UserDefaults.standard.removeObject(forKey: storageKey)
  }
}
