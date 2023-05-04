//
//  NetworkManager.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 27.04.2023.
//

import Foundation
import RxSwift
import Alamofire

public final class NetworkManager {
    static let shared = NetworkManager()
    
    public func request<T: Decodable>(path: String, headers: HTTPHeaders, bearerToken: String) -> Observable<T> {
        return Observable.create { observer in
            AF.request(path, method: .get, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let model):
                        observer.onNext(model)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                        print("An error occured during the API request. [\(error)]")
                    }
                }
            return Disposables.create()
        }
    }
}

