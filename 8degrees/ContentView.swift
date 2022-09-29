//
//  ContentView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            VStack {
                TitleView()
                ScrollView {
                    MainNoticeBannerView()
                    MainCategoryView()
                    BoxOfficeView()
                    UpComingView()
                    //                PageView(pages: ModelData().landmarks.map {CarouselView(landmark: $0)} )
                    //                    .frame(width: UIScreen.main.bounds.width, height: 130)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }.background(Color.indigo)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
