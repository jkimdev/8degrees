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
                        .frame(width: 75, height: 75)
                        .cornerRadius(8)
                    Text(performance.title)
                }
                .onAppear {
                    if performance.performanceId == self.viewModel.performances.last?.performanceId && self.viewModel.isFetchable {
                        self.viewModel.getPerformanceList(genre: title, offset: self.viewModel.offset, limit: self.viewModel.limit)
                    }
                }
            }
        }
        .navigationBarTitle(self.viewType == .GENRE ? title.codeToString : title)
        .onAppear {
            switch viewType {
            case .GENRE:
                self.viewModel.getPerformanceList(genre: self.title, offset: self.viewModel.offset, limit: self.viewModel.limit)
            case .SEARCH:
                self.viewModel.getNearPerformances(facility: facilityId ?? "", offset: self.viewModel.offset, limit: self.viewModel.limit)
            }
        }
    }
}

extension ContentListView {
    class viewModel: ObservableObject {
        @Published var performances: [Performance] = []
        @Published var isLoading: Bool = false
        var offset: Int = 0
        var limit: Int = 15
        var isFetchable: Bool = true
        var cancellable = Set<AnyCancellable>()
        
        func getNearPerformances(facility: String, offset: Int, limit: Int) {
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformanceByFacility(facilityId: facility, offset: offset, limit: limit))
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
        
        func getPerformanceList(genre: String, offset: Int, limit: Int) {
            //            self.isLoading = true
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformancesByGenre(genre: genre, offset: offset, limit: limit))
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get performances done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.offset += limit
                    self?.performances.append(contentsOf: response.result)
                    if response.result.count < limit {
                        self?.isFetchable = false
                    }
                }
                .store(in: &cancellable)
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView(title: "AAAA", viewType: .GENRE)
    }
}
