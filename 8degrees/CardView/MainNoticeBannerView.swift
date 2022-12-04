//
//  MainNoticeBannerView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/25.
//

import SwiftUI

struct MainNoticeBannerView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("힘내요! 경북/강원")
                    .font(.regular(size: 8))
                Text("산불피해지역 선착순 3만원 할인")
                    .font(.bold(size: 16))
            }.padding()
            
            Spacer()
        }
        .background(Color(.sRGB,red: 230/255, green: 252/255, blue: 235/255)).cornerRadius(8)
        .padding([.horizontal, .bottom])
    }
}

struct MainNoticeBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MainNoticeBannerView()
    }
}
