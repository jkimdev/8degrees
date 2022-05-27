//
//  VerticalLabelStyle.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/27.
//

import SwiftUI




struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
            configuration.title
        }
    }
}

extension LabelStyle where Self == VerticalLabelStyle{
    static var vertical: VerticalLabelStyle {
        VerticalLabelStyle()
    }
}
