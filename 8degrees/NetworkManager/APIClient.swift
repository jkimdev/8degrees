//
//  APIClient.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/30.
//

import Foundation
import Alamofire

class APIClient {
    typealias onSuccess<T> = ((T) -> Void)
    typealias onFailure = ((_ error: Error) -> Void)
    
    static let shared = APIClient()
        
    func request<T>(_ object: T.Type, router: APIRouter, success: @escaping onSuccess<T>, failure: @escaping onFailure) where T:Decodable {
        AF.request(router)
            .validate(statusCode: 200 ..< 500)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success:
                    guard let decodeData = response.value else { return }
                    success(decodeData)
                case .failure(let err):
                    failure(err)
                }
            }
    }
}
