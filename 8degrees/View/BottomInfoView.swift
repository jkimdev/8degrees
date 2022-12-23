//
//  BottomInfoView.swift
//  8degrees
//
//  Created by 김재민 on 2022/10/14.
//

import SwiftUI
import Kingfisher

struct BottomInfoView: View {
    let performance: Performance
    var body: some View {
        HStack(spacing: 32) {
            KFImage(URL(string: performance.poster))
                .centerCropped()
                .frame(width: 115, height: 150, alignment: .center)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 8) {
                Text(performance.genre.codeToString)
                    .font(.light(size: 8))
                Text(performance.title)
                    .font(.bold(size: 16))
                Text(performance.runtime ?? "")
                    .font(.light(size: 12))
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct BottomInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BottomInfoView(performance: Performance(performanceId: "P001", title: "재밌는 공연", poster: "http://www.kopis.or.kr/upload/pfmPoster/PF_PF163755_200422_092850.gif", story: "This is a story", genre: "AAAA", rating: "전체", startDate: "2022-09-01", endDate: "2022-09-21", state: "ONGOING", runtime: "2시간"))
    }
}
