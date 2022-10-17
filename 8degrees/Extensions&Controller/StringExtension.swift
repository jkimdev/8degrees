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
        return day != 0 ? String(day) : "-Day"
    }
}
