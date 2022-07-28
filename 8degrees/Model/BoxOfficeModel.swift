//
//  PerformanceModel.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/28.
//

import Foundation

struct BoxOffices: Decodable {
    let BoxOffices: [BoxOffice]
}

struct BoxOffice: Decodable {
    let performanceId: String
    let ranking: Int
    let title: String
    let genre: String
    let poster: String
}
