//
//  BoxOfficeCardView.swift
//  8degrees
//
//  Created by 김재민 on 2022/08/24.
//

import SwiftUI
import Kingfisher

struct BoxOfficeCardView: View {
    var boxOffice: BoxOffice
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                VStack {
                    KFImage(URL(string: boxOffice.poster))
                        .centerCropped()
                        .overlay (
                            LinearGradient(colors: [.clear, .black.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 160, height: 225, alignment: .center)
                        .cornerRadius(8)
                }
                Text("\(boxOffice.ranking)").font(.system(size: 50).bold().italic()).foregroundColor(Color.white).padding(.bottom, -8)
            }
            Image(boxOffice.genre.toIcon).renderingMode(.template).foregroundColor(.white)
        }
    }
}

//struct BoxOfficeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxOfficeCardView(boxOffice: BoxOffice(performanceId: "1", ranking: 1, title: "모노폴리", genre: "AAAA", poster: "http://www.kopis.or.kr/upload/pfmPoster/PF_PF163755_200422_092850.gif", story: nil))
//    }
//}
