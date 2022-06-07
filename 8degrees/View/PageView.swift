//
//  PageView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/29.
//

import SwiftUI

struct PageView<Page:View>: View {
    var pages:[Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            ZStack {
                Capsule()
                    .opacity(0.3)
                    .frame(width: 50, height: 25)
                    .padding()
            }.overlay {
                Text("\(currentPage+1)/\(pages.count)")
                    .foregroundColor(.white)
            }
            //            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
            //                .frame(width: CGFloat(pages.count * 18))
            //                .padding(.trailing)
        }.frame(width: UIScreen.main.bounds.width, height: 130)
        
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().landmarks.map {CarouselView(landmark: $0)} )
            .aspectRatio(3 / 2, contentMode: .fit)
        
    }
}
