//
//  GenreModel.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/05.
//

import SwiftUI

struct GenreResponse: Decodable {
    let code: Int
    let result: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let code: String
    let value: String
    let image: String
}
