//
//  APIRouter.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/29.
//

import Alamofire
import Foundation

enum APIRouter {
    case getHome
    case getPerformancesByGenre(genre: String, offset: Int, limit: Int)
    case getBoxOffices
    case getPerformanceById(id: String)
    case getUpComingPerformance(offset: Int, limit: Int)
    case getGenres
    case getNearFacility(latitude: Double, longitude: Double)
    case getPerformanceByFacility(facilityId: String, offset: Int, limit: Int)
}

extension APIRouter: URLRequestConvertible {
    var baseURL: URL {
        return URL(string: "http://54.180.3.150:8080/api/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHome,
             .getBoxOffices,
             .getPerformanceByFacility,
             .getPerformanceById,
             .getGenres,
             .getPerformancesByGenre,
             .getUpComingPerformance,
             .getNearFacility:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHome:
            return "home"
        case .getBoxOffices:
            return "top10BoxOffice"
        case .getPerformanceById(let id):
            return "performance/\(id)"
        case .getGenres:
            return "genres"
        case .getPerformancesByGenre:
            return "performance/genre"
        case .getUpComingPerformance:
            return "performance/upComing"
        case .getNearFacility:
            return "facility/near"
        case .getPerformanceByFacility:
            return "performance/facility"
        }
    }
    
    var header: HTTPHeader? {
        // TODO: User-Agent iOS
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .getHome,
             .getBoxOffices,
             .getPerformanceById,
             .getGenres:
            return nil
        case .getPerformancesByGenre(genre: let genre, offset: let offset, limit: let limit):
            return ["genre": genre, "offset": offset, "limit": limit]
        case .getUpComingPerformance(offset: let offset, limit: let limit):
            return ["offset": offset, "limit": limit]
        case .getNearFacility(latitude: let latitude, longitude: let longitude):
            return ["latitude": latitude, "longitude": longitude]
        case .getPerformanceByFacility(facilityId: let facilityId, offset: let offset, limit: let limit):
            return ["facilityId": facilityId, "offset": offset, "limit": limit]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = nil
        
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: parameters)
    }
}
