//
//  HomeModel.swift
//  8degrees
//
//  Created by Jimmy on 2022/12/23.
//

import SwiftUI

struct HomeModel: Decodable {
    let exhibitions: [Exhibition]?
    let genres: [Genre]?
    let boxOffices: [BoxOffice]?
    let upcomingPerformances: [Performance]?
}
