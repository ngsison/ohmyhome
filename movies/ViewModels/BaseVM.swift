//
//  BaseVM.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import RxSwift

class BaseVM {
  public let disposeBag = DisposeBag()
  public var adapter: SearchAdapterType
  
  public var isSuccess: Variable<Bool> = Variable(false)
  public var isLoading: Variable<Bool> = Variable(false)
  public var errorMessage: Variable<String> = Variable("")
  
  init(adapter: SearchAdapterType = SearchAdapter()) {
    self.adapter = adapter
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
}
