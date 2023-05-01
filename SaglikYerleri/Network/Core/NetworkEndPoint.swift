//
//  NetworkEndPoint.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import Alamofire

protocol NetworkEndPoint {
    var apiKey: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
}
