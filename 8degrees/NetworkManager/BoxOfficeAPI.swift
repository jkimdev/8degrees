//
//  BoxOfficeAPI.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/29.
//

import Foundation
import Alamofire

enum BoxOfficeAPI {
    case getBoxOffice
}

extension BoxOfficeAPI: URLRequestConvertible {
    
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8080")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBoxOffice:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getBoxOffice:
            return "/boxoffice"
        }
    }
    
    var header: HTTPHeader? {
        /// todo ::  User-Agent iOS
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .getBoxOffice:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod  = method.rawValue
        urlRequest.allHTTPHeaderFields = nil
        
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
