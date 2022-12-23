//
//  UpComingView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/16.
//

import SwiftUI
import Combine

struct UpComingView: View {
    let performances: [Performance]
    var body: some View {
        VStack(alignment: .leading) {
            Text("🎭 다가오는 공연").font(.bold(size: 18)).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(self.performances, id: \.performanceId) { post in
                            NavigationLink(destination: SingleContentView(performanceId: post.performanceId)) {
                                UpComingCardView(performance: post)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
        //        .overlay{
        //            self.viewModel.isLoading ? ProgressView(value: 0)
        //                .progressViewStyle(CircularProgressViewStyle(tint: .red)) : nil
        //        }
    }
}
