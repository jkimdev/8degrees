//
//  APIClient.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/30.
//

import Foundation
import Alamofire
import Combine

class APIClient {
    static let shared = APIClient()
        
    func request<T: Decodable>(_ object: T.Type, router: APIRouter) -> AnyPublisher<T, AFError> {
        AF.request(router)
            .validate(statusCode: 200 ..< 500)
            .publishDecodable(type: T.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
