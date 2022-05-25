//
//  MainNoticeBannerView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/25.
//

import SwiftUI

struct MainNoticeBannerView: View {
    var body: some View {
        ZStack{
        HStack {
            VStack(alignment: .leading) {
                Text("힘내요! 경북/강원")
                Text("산불피해지역 선착순 3만원 할인")
            }
            
            Spacer()
        }
        }.background(Color(.sRGB,red: 230/255, green: 252/255, blue: 235/255)).cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(.sRGB,red: 230/255, green: 252/255, blue: 235/255)))
            .padding(.horizontal)
    }
}

struct MainNoticeBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MainNoticeBannerView()
    }
}
