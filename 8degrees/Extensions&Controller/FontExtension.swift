//
//  FontExtension.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/25.
//

import SwiftUI

extension Font {
    static func regular(size: Int) -> Font {
        return Font.custom("DalseoDarling", size: CGFloat(size))
    }
    
    static func light(size: Int) -> Font {
        return Font.custom("DalseoHealingBold", size: CGFloat(size))
    }
    
    static func bold(size: Int) -> Font {
        return Font.custom("DalseoHealingBold", size: CGFloat(size))
    }
}
