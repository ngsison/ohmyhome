//
//  StubbedResponse.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

func stubbedResponse(_ filename: String) -> Data! {
  @objc class TestClass: NSObject {}
  
  let bundle = Bundle(for: TestClass.self)
  let path = bundle.path(forResource: filename, ofType: "json")
  return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
