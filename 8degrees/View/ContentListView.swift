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

enum ViewType {
    case GENRE
    case SEARCH
}

struct ContentListView: View {
    @StateObject var viewModel = viewModel()
    let facilityId: String?
    let title: String
    let viewType: ViewType
    
    init(facilityId: String? = nil, title: String, viewType: ViewType) {
        self.facilityId = facilityId
        self.title = title
        self.viewType = viewType
    }
    
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
        .navigationBarTitle(self.viewType == .GENRE ? self.viewModel.genreToString(title) : title)
        .onAppear {
            switch viewType {
            case .GENRE:
                self.viewModel.getPerformanceList(genre: self.title)
            case .SEARCH:
                self.viewModel.getNearPerformances(facility: facilityId ?? "", startIdx: "1", endIdx: "15")
            }
        }
    }
}

extension ContentListView {
    class viewModel: ObservableObject {
        @Published var performances: [Performance] = []
        @Published var isLoading: Bool = false
        var cancellable = Set<AnyCancellable>()
        
        func getNearPerformances(facility: String, startIdx: String, endIdx: String) {
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformanceByFacility(facilityId: facility, startIdx: startIdx, endIdx: endIdx))
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get near performances done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.performances = response.result
                }
                .store(in: &cancellable)
        }
        
        func getPerformanceList(genre: String) {
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
        ContentListView(title: "AAAA", viewType: .GENRE)
    }
}
