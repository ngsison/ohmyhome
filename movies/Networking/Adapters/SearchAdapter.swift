//
//  SearchAdapter.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 02/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

protocol SearchAdapterType {
  func search(query: String, page: Int) -> Observable<SearchResult>
}

class SearchAdapter: SearchAdapterType {
  
  private let disposeBag = DisposeBag()
  private var provider: MoyaProvider<SearchAPI>
  
  init(provider: MoyaProvider<SearchAPI> = MoyaProvider<SearchAPI>()) {
    self.provider = provider
  }
  
  func search(query: String, page: Int) -> Observable<SearchResult> {
    return Observable.create { observer in
      self.provider.rx
        .request(.search(query: query, page: page))
        .filterSuccessfulStatusCodes()
        .subscribe(onSuccess: { response in
          if let searchResult = SearchResult(json: JSON(response.data)) {
            observer.onNext(searchResult)
          } else {
            observer.onError(APIError.invalidJson)
          }
        }, onError: { error in
          observer.onError(error)
        }).disposed(by: self.disposeBag)
      
      return Disposables.create()
    }
  }
}
