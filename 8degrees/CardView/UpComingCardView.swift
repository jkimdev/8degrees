//
//  UpComingCardView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/19.
//

import SwiftUI
import Kingfisher

struct UpComingCardView: View {
    var performance: Performance
    let currentDate: Date = Date.now
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                VStack {
                    KFImage(URL(string: performance.poster))
                        .centerCropped()
                        .frame(width: 160, height: 225, alignment: .center)
                        .cornerRadius(8)
                }
                //                Text("\(boxOffice.ranking)").font(.system(size: 50).bold().italic()).foregroundColor(Color.white).padding(.bottom, -8)
            }
            Text("D\(performance.startDate.dayUntil(currentDate))")
                .font(.fontRegular(size: 8))
                .padding(8)
                .foregroundColor(.white)
                .background(.black)
                .clipShape(Capsule())
        }
    }
}

struct UpComingCardView_Previews: PreviewProvider {
    static var previews: some View {
        UpComingCardView(performance: Performance(performanceId: "1", title: "팔도: 개발자의 반란", poster: "http://www.kopis.or.kr/upload/pfmPoster/PF_PF163755_200422_092850.gif", genre: "musical", startDate: "2022-09-01"))
    }
}
