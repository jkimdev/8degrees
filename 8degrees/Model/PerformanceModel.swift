//
//  PerformanceModel.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/07.
//

import Foundation

struct PerformanceResponse: Decodable {
    let code: Int
    let result: [Performance]
}

struct Performance: Decodable {
    let performanceId: String
    let title: String
    let poster: String
    let story: String?
    let genre: String
    let rating: String
    let startDate: String
    let endDate: String
    let state: String?
    let runtime: String?
}
