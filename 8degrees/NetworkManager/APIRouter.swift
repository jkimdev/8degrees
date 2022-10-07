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
    case getUpComingPerformance(date: String, startIdx: String, endIdx: String)
    case getGenres
    case getNearFacility(latitude: Double, longitude: Double)
}

extension APIRouter: URLRequestConvertible {
    
    var baseURL: URL {
        return URL(string: "http://172.30.1.60:8080")!
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
        case .getUpComingPerformance:
            return .get
        case .getNearFacility:
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
        case .getUpComingPerformance:
            return "performance/upComing"
        case .getNearFacility:
            return "facility/near"
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
        case .getUpComingPerformance(date: let date, startIdx: let startIdx, endIdx: let endIdx):
            return ["date": date, "startIdx": startIdx, "endIdx": endIdx]
        case .getNearFacility(latitude: let latitude, longitude: let longitude):
            return ["latitude": latitude, "longitude": longitude]
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
