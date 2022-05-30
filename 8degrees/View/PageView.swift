//
//  PageView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/29.
//

import SwiftUI

struct PageView<Page:View>: View {
    var pages:[Page]
    var body: some View {
        
        PageViewController(pages: pages)
        
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().landmarks.map {CarouselView(landmark: $0)} )
            .aspectRatio(3 / 2, contentMode: .fit)
        
    }
}
