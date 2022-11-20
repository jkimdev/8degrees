//
//  ContentListView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/07.
//

import SwiftUI
import Alamofire
import Kingfisher
import Combine

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
        }
        .navigationBarTitle(self.viewModel.genreToString(genre))
        .task {
            await self.viewModel.getPerformanceList(genre: self.genre)
        }
    }
}

extension ContentListView {
    class viewModel: ObservableObject {
        @Published var performances: [Performance] = []
        @Published var isLoading: Bool = false
        var cancellable = Set<AnyCancellable>()
        
        func getPerformanceList(genre: String) async {
            //            self.isLoading = true
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformancesByGenre(genre: genre, startIdx: 1, endIdx: 30))
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get boxoffice done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.performances = response.result
                }
                .store(in: &cancellable)
        }
        
        func genreToString(_ genre: String) -> String {
            switch genre {
            case "AAAA":
                return "연극"
            case "AAAB":
                return "뮤지컬"
            case "BBBA":
                return "무용"
            case "CCCA":
                return "클래식"
            case "CCCB":
                return "오페라"
            case "CCCC":
                return "국악"
            case "EEEA":
                return "복합"
            default:
                return "UNKNOWN"
            }
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView(genre: "AAAA")
    }
}
