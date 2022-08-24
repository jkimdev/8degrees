//
//  BoxOfficeCardView.swift
//  8degrees
//
//  Created by 김재민 on 2022/08/24.
//

import SwiftUI

struct BoxOfficeCardView: View {
    var boxOffice: BoxOffice
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                VStack {
                    AsyncImage(url: URL(string: boxOffice.poster), content: { image in
                        image.centerCropped().cornerRadius(8)
                            .frame(width: 160, height: 225, alignment: .center)
                    },
                               placeholder: {
                        ProgressView()
                    })
                }
                
                Text("\(boxOffice.ranking)").font(.system(size: 50).bold().italic()).foregroundColor(Color.white).padding(.bottom, -8)
            }
            Image(systemName: "theatermasks.fill").renderingMode(.template).foregroundColor(.white)
        }
    }
}

struct BoxOfficeCardView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeCardView(boxOffice: BoxOffice(performanceId: "1", ranking: 1, title: "모노폴리", genre: "Action", poster: "http://www.kopis.or.kr/upload/pfmPoster/PF_PF163755_200422_092850.gif"))
    }
}
