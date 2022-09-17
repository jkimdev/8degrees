//
//  APIRouter.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/29.
//

import Foundation
import Alamofire

enum APIRouter {
    case getPerformancesByGenre(genre: String, startIdx: Int, endIdx: Int)
    case getBoxOffices
    case getPerformanceById(id: String)
    case findUpComingPerformance(date: String)
    case getGenres
}

extension APIRouter: URLRequestConvertible {
    
    var baseURL: URL {
        return URL(string: "http://172.30.1.9:8080")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBoxOffices:
            return .get
        case .getPerformanceById:
            return .get
        case .getGenres:
            return .get
        case .getPerformancesByGenre:
            return .get
        case .findUpComingPerformance:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getBoxOffices:
            return "/top10BoxOffice"
        case .getPerformanceById(let id):
            return "/performance/\(id)"
        case .getGenres:
            return "/genres"
        case .getPerformancesByGenre:
            return "performance/genre"
        case .findUpComingPerformance:
            return "performance/upComing"
        }
    }
    
    var header: HTTPHeader? {
        /// todo ::  User-Agent iOS
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .getBoxOffices:
            return nil
        case .getPerformanceById:
            return nil
        case .getGenres:
            return nil
        case .getPerformancesByGenre(genre: let genre, startIdx: let startIdx, endIdx: let endIdx):
            return ["genre": genre, "startIdx": startIdx, "endIdx": endIdx]
        case .findUpComingPerformance(date: let date):
            return ["date": date]
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
