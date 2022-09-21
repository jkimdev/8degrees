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
                                                                UpComingCardView(performance: post)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
        .task{
            await self.viewModel.getUpComing(date: "2022-09-01")
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
        
        func getUpComing(date: String) async {
            APIClient.shared.request(PerformanceResponse.self, router: .findUpComingPerformance(date: date, startIdx: "1", endIdx: "10")) { [weak self] response in
                self?.performances = response.result
                
            } failure: { error in
                print(error.localizedDescription)
            }
        }
    }
}
