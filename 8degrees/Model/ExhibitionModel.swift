//
//  ExhibitionModel.swift
//  8degrees
//
//  Created by Jimmy on 2023/01/17.
//

import SwiftUI

struct Exhibition: Decodable {
    let performanceId: String
    let ranking: Int
    let title: String
    let genre: String
    let poster: String
    let story: String
    let area: String
    let place: String
    let startDate: String
    let endDate: String
    let link: String
}
