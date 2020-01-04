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
  
  /**
   Adds a suggestion to the beginning of the previously saved list of suggestions.
   
   - If the given suggestion is already saved previously, it will just move it to the start of the suggestion list.
   - It will only save maximum of `suggestionsLimit` of suggestions.
   */
  
  public func add(_ suggestion: String) {
    var suggestions = self.load()
    
    suggestions = suggestions.filter { $0 != suggestion }
    suggestions.insert(suggestion, at: 0)
    
    if suggestions.count > self.suggestionsLimit {
      let mostRecentSuggestions = suggestions[..<self.suggestionsLimit]
      UserDefaults.standard.set(Array(mostRecentSuggestions), forKey: storageKey)
    } else {
      UserDefaults.standard.set(suggestions, forKey: storageKey)
    }
  }
  
  /**
   Returns the saved lists of suggestions.
   
   - It will return an empty list of suggestions if nothing was found on the local storage.
   */
  
  public func load() -> [String] {
    guard let savedSuggestions = UserDefaults.standard.array(forKey: storageKey) as? [String] else {
      return [String]()
    }
    
    return savedSuggestions
  }
  
  /**
   Removes the saved list of suggestions from the local storage.
   */
  
  public func clear() {
    UserDefaults.standard.removeObject(forKey: storageKey)
  }
}
