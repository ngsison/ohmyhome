//
//  BaseVM.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import Moya
import RxSwift

class BaseVM {
  
  // MARK: - Public Props
  
  public let disposeBag = DisposeBag()
  public var adapter: SearchAdapterType
  
  public var isSuccess: Variable<Bool> = Variable(false)
  public var isLoading: Variable<Bool> = Variable(false)
  public var errorMessage: Variable<String> = Variable("")
  
  // MARK: - Public Methods
  
  init(adapter: SearchAdapterType = SearchAdapter()) {
    self.adapter = adapter
    self.adapter = fakeAdapter() // Comment / Uncomment this line to use mock data.
  }
  
  public func showLoading() {
    self.isSuccess.value = false
    self.isLoading.value = true
    self.errorMessage.value = ""
  }
  
  public func success() {
    self.isSuccess.value = true
    self.isLoading.value = false
    self.errorMessage.value = ""
  }
  
  public func hasError(_ errorMessage: String) {
    self.isSuccess.value = false
    self.isLoading.value = false
    self.errorMessage.value = errorMessage
  }
  
  // MARK: - Private Methods
  
  private func fakeAdapter() -> SearchAdapterType {
    let endpointClosure = { (target: SearchAPI) -> Endpoint in
      return Endpoint(url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                      sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: nil)
    }
    
    let stubClosure = { (_: SearchAPI) -> Moya.StubBehavior in
      return .delayed(seconds: 1)
    }
    
    let fakeProvider = MoyaProvider<SearchAPI>(endpointClosure: endpointClosure,
                                               stubClosure: stubClosure)
    
    return SearchAdapter(provider: fakeProvider)
  }
}
