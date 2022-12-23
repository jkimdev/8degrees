//
//  BoxOffice.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/30.
//

import SwiftUI
import Alamofire
import Combine

struct BoxOfficeView: View {
    let boxOffices: [BoxOffice]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("🎬 금주의 TOP 10").font(.bold(size: 18)).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(self.boxOffices, id: \.performanceId) { post in
                            NavigationLink(destination: SingleContentView(performanceId: post.performanceId)) {
                                BoxOfficeCardView(boxOffice: post)
                            }
                        }
                    }.padding([.horizontal, .bottom])
                }
            }
        }
//        .overlay{
//            self.viewModel.isLoading ? ProgressView(value: 0)
//                .progressViewStyle(CircularProgressViewStyle(tint: .red)) : nil
//        }
    }
}
