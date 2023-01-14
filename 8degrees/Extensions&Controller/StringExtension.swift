//
//  StringExtension.swift
//  8degrees
//
//  Created by 김재민 on 2022/10/07.
//

import Foundation

extension String {
    func dayUntil(_ currentDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date.now
        let targetDate = dateFormatter.date(from: self)!
        let day = Calendar.current.dateComponents([.day],
                                                  from: currentDate,
                                                  to: targetDate).day ?? 0
        return day != 0 ? "-\(day)" : "-Day"
    }
    
    var codeToString: String {
        switch self {
        case "AAAA":
            return "연극"
        case "AAAB":
            return "뮤지컬"
        case "BBBA":
            return "무용"
        case "CCCA":
            return "클래식"
        case "CCCB":
            return "오페라"
        case "CCCC":
            return "국악"
        case "EEEA":
            return "복합"
        default:
            return "UNKNOWN"
        }
    }
    
    var toIcon: String {
        switch self {
        case "AAAA":
            return "film"
        case "AAAB":
            return "music.note"
        case "BBBA":
            return "drop"
        case "CCCA":
            return "bolt"
        case "CCCB":
            return "theatermasks"
        case "CCCC":
            return "leaf"
        case "EEEA":
            return "heart"
        default:
            return ""
        }
    }
}
