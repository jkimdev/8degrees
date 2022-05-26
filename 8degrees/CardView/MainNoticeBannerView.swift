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
                VStack(alignment: .leading, spacing: 5) {
                    Text("힘내요! 경북/강원")
                        .font(.fontRegular(size: 10))
                    Text("산불피해지역 선착순 3만원 할인")
                        .font(.fontBold(size: 15))
                }.padding(10)
                
                Spacer()
            }
        }.background(Color(.sRGB,red: 230/255, green: 252/255, blue: 235/255)).cornerRadius(5)
            .padding(.horizontal)
    }
}

struct MainNoticeBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MainNoticeBannerView()
    }
}
