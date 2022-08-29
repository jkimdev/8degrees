//
//  SingBoxOfficeModel.swift
//  8degrees
//
//  Created by 김재민 on 2022/08/29.
//

import Foundation

struct SingBoxOfficeResponse: Decodable {
    let code: Int
    let result: [SingBoxOffice]
}

struct SingBoxOffice: Decodable {
    let performanceId: String
    let title: String
    let poster: String
}
