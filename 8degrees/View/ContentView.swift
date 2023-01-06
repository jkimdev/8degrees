//
//  ContentView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/05.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = viewModel()
    var body: some View {
        
        NavigationView {
            VStack {
                TitleView()
                ScrollView(showsIndicators: false) {
                    MainNoticeBannerView()
                    MainCategoryView(genres: self.viewModel.homeData?.genres ?? [])
                    BoxOfficeView(boxOffices: self.viewModel.homeData?.boxOffices ?? [])
                    UpComingView(performances: self.viewModel.homeData?.upcomingPerformances ?? [])
                    if let exhibitions = self.viewModel.homeData?.exhibitions {
                        PageView(pages: exhibitions.map { ExhibitionView(exhibition: $0) })
                            .aspectRatio(3 / 2, contentMode: .fit)
                    }
                }
                .refreshable {
                    self.viewModel.getHome()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
        .background(Color.indigo)
        .navigationViewStyle(.stack)
    }
}

extension ContentView {
    class viewModel: ObservableObject {
        @Published var homeData: HomeModel? = nil
        var cancellable = Set<AnyCancellable>()
        
        init() {
            getHome()
        }
        
        func getHome() {
            APIClient.shared.request(APIResponse<HomeModel>.self , router: .getHome)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("get home success!")
                    case .failure(let error):
                        dump(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.homeData = response.result
                    dump(self?.homeData)
                }
                .store(in: &cancellable)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
