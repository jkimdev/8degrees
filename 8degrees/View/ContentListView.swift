//
//  ContentListView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/07.
//

import SwiftUI
import Alamofire
import Kingfisher

struct ContentListView: View {
    @StateObject var viewModel = ContentListView.viewModel()
    var genre: String
    var body: some View {
            List(self.viewModel.performances, id: \.performanceId) { performance in
                NavigationLink {
                    SingleContentView(performanceId: performance.performanceId)
                } label: {
                    HStack(alignment: .top) {
                        KFImage(URL(string: performance.poster))
                            .centerCropped()
                            .frame(width: 75, height: 100)
                            .cornerRadius(8)
                        Text(performance.title)
                    }

                }
            }.task {
                await self.viewModel.getPerformanceList(genre: self.genre)
            }
    }
}

extension ContentListView {
    class viewModel: ObservableObject {
        @Published var performances: [Performance] = []
        @Published var isLoading: Bool = false
        
        func getPerformanceList(genre: String) async {
            self.isLoading = true
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformancesByGenre(genre: genre, startIdx: 1, endIdx: 30)) { [weak self] response in
                
                self?.performances = response.result
                self?.isLoading = false

            } failure: { error in
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView(genre: "AAAA")
    }
}
