//
//  RequestExtension.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

public typealias APIResult<T: Jsonable> = (result: T?, error: Error?)
public typealias APIArrayResult<T: Jsonable> = (result: [T], error: Error?)

public extension Reactive where Base: MoyaProviderType {
    
    /*
    public func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.error(error))
                }
            }
     
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    */

    public func requestGetObject<T: Jsonable>(ofType jsonableType: T.Type, _ token: Base.Target, disposeBag: DisposeBag? = nil, callbackQueue: DispatchQueue? = nil, keypath: String? = nil) -> BehaviorRelay<APIResult<T>?> {
        
        let relay = BehaviorRelay<APIResult<T>?>(value: nil)
        let sentRequest = self.self.request(token)
        
        let disposable = sentRequest.subscribe { event in
            switch event {
                
                // Handle success response
                case let .success(response):
                    let apiResponse = response.mapApi()
                    let object = apiResponse.toObject(T.self)
                    relay.accept((result: object, error: nil))
                
                // Handle error
                case let .error(error):
                    relay.accept((result: nil, error: error))
            }
        }
            
        if let theDisposeBag = disposeBag {
            disposable.disposed(by: theDisposeBag)
        }
        
        return relay
    }

    public func requestGetArray<T: Jsonable>(ofType jsonableType: T.Type, _ token: Base.Target, disposeBag: DisposeBag? = nil, callbackQueue: DispatchQueue? = nil, keypath: String? = nil) ->  (BehaviorRelay<APIArrayResult<T>?>) {
        
        let relay = BehaviorRelay<APIArrayResult<T>?>(value: nil)
        let sentRequest = self.self.request(token)
        
        let disposable = sentRequest.subscribe { event in
            switch event {
                
            // Handle success response
            case let .success(response):
                let apiResponse = response.mapApi()
                let object = apiResponse.toArray([T.self])
                relay.accept((result: object, error: nil))

            // Handle error
            case let .error(error):
                relay.accept((result: [], error: error))
            }
        }
        
        if let theDisposeBag = disposeBag {
            disposable.disposed(by: theDisposeBag)
        }
        
        return relay
    }
}
