//
//  ColorExtension.swift
//  8degrees
//
//  Created by Jimmy on 2022/12/17.
//

import SwiftUI

extension Color {
    static var random: Color {
        let randomInt = Int.random(in: 0..<9)
        switch randomInt {
        case 0:
            return .blue
        case 1:
            return .brown
        case 2:
            return .gray
        case 3:
            return .black
        case 4:
            return .orange
        case 5:
            return .green
        case 6:
            return .purple
        case 7:
            return yellow
        case 8:
            return .red
        default:
            return .random
        }
    }
}
