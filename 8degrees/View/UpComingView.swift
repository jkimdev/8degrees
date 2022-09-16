//
//  UpComingView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/16.
//

import SwiftUI

struct UpComingView: View {
    @ObservedObject var viewModel = UpComingView.viewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("🎭 다가오는 공연").font(.fontBold(size: 18)).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(self.viewModel.performances, id: \.performanceId) { post in
                            NavigationLink(destination: SingleContentView(performanceId: post.performanceId)) {
//                                UpcomingCardView(performance: post)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
        .task{
            await self.viewModel.getUpComing()
        }
//        .overlay{
//            self.viewModel.isLoading ? ProgressView(value: 0)
//                .progressViewStyle(CircularProgressViewStyle(tint: .red)) : nil
//        }
    }
}

struct UpComingView_Previews: PreviewProvider {
    static var previews: some View {
        UpComingView()
    }
}

extension UpComingView {
    class viewModel: ObservableObject {
        @Published var performances: [Performance] = []
        
        func getUpComing() async {
            
        }
    }
}
