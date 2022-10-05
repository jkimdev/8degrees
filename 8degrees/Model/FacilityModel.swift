//
//  FacilityModel.swift
//  8degrees
//
//  Created by 김재민 on 2022/10/02.
//

import Foundation

struct FacilityResponse: Decodable {
    let code: Int
    let result: [Facility]
}

struct Facility: Decodable, Identifiable {
    var id: String {
        self.facilityId
    }
    let facilityId: String
    let place: String
    let telNo: String
    let url: String
    let address: String
    let latitude: Double
    let longitude: Double
    let distance: Double
}
