//
//  FontExtension.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/25.
//

import SwiftUI

extension Font {
    static func fontRegular(size: Int) -> Font {
        return Font.custom("ONEMobileOTFRegular", size: CGFloat(size))
    }
    
    static func fontLight(size: Int) -> Font {
        return Font.custom("ONEMobileOTFLight", size: CGFloat(size))
    }
    
    static func fontBold(size: Int) -> Font {
        return Font.custom("ONEMobileOTFBold", size: CGFloat(size))
    }
}
