//
//  APIResponse.swift
//  8degrees
//
//  Created by Jimmy on 2022/12/23.
//

import SwiftUI

struct APIResponse<T: Decodable>: Decodable {
    let code: Int
    let result: T
}
