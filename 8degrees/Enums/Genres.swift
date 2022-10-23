//
//  Genres.swift
//  8degrees
//
//  Created by 김재민 on 2022/10/23.
//

import Foundation

enum Genres: String {
    case AAAA = "연극"
    case AAAB = "뮤지컬"
    case BBBA = "무용"
    case CCCA = "클래식"
    case CCCB = "오페라"
    case CCCC = "국악"
    case EEEA = "복합"
    
    init?(code: String) {
        switch code {
        case "AAAA":
            self = .AAAA
        case "AAAB":
            self =  .AAAB
        case "BBBA":
            self = .BBBA
        case "CCCA":
            self = .CCCA
        case "CCCB":
            self = .CCCB
        case "CCCC":
            self = .CCCC
        case "EEEA":
            self = .EEEA
        default:
            return nil
        }
    }
}
