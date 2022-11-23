//
//  MainCategoryView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/26.
//

import SwiftUI
import Alamofire
import Combine

struct MainCategoryView: View {
    
    @ObservedObject var viewModel = MainCategoryView.viewModel()
    var columns: [GridItem] = [GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80))]
    
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(self.viewModel.genres, id: \.id) { genre in
                NavigationLink(destination: {
                    ContentListView(genre: genre.code)
                }, label: {
                    Label(title: { Text(genre.value) }, icon: { Image(systemName: genre.image).imageScale(.large) }).labelStyle(.vertical)
                })
            }
        }
        .padding(.bottom)
        .task {
            await self.viewModel.getGenres()
        }
    }
}

extension MainCategoryView {
    class viewModel: ObservableObject {
        @Published private(set) var genres: [Genre] = []
        @Published private(set) var isLoading: Bool = false
        var cancellable = Set<AnyCancellable>()

        func getGenres() async {
            //            self.isLoading = true
            APIClient.shared.request(GenreResponse.self, router: APIRouter.getGenres)
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get boxoffice done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.genres = response.result
                }
                .store(in: &cancellable)
        }
    }
}

struct MainCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainCategoryView()
    }
}
