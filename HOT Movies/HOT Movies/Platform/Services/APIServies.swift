//
//  APIServies.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxCocoa
import Then

struct APIServices {
    
    public static let shared = APIServices()
    
    private var alamofireManager = Alamofire.Session.default
    
    private init() {
        let configuration = URLSessionConfiguration.default.then {
            $0.timeoutIntervalForResource = 30
            $0.timeoutIntervalForRequest = 30
        }
        alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    func request<T: Mappable>(URL: String, responseType: T.Type) -> Observable<T> {
        return Observable.create { observable in
            self.alamofireManager.request(URL)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                            observable.onError(BaseError.HTTPError)
                            return
                        }
                        guard let object = Mapper<T>().map(JSONObject: value) else {
                            observable.onError(BaseError.mapError)
                            return
                        }
                        observable.onNext(object)
                        observable.onCompleted()
                    case .failure:
                        observable.onError(BaseError.networkError)
                    }
                }
            return Disposables.create()
        }
    }
    
}
