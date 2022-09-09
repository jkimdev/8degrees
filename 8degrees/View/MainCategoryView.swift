//
//  MainCategoryView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/26.
//

import SwiftUI
import Alamofire

struct MainCategoryView: View {
    
    @ObservedObject var viewModel = MainCategoryView.viewModel()
    var columns: [GridItem] = [GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80))]
    
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(self.viewModel.genres, id: \.id) { genre in
                NavigationLink(destination: {
                    ContentListView(genre: genre.code)
                }, label: {
                    Label(title: { Text(genre.value) }, icon: { Image(systemName: genre.image).imageScale(.large) }).labelStyle(.vertical)
                })
            }
//            Label(title: { Text("globe") }, icon: { Image(systemName: "globe.americas.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("flame") }, icon: { Image(systemName: "flame.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("drop") }, icon: { Image(systemName: "drop.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("bolt") }, icon: { Image(systemName: "bolt.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("allergens") }, icon: { Image(systemName: "allergens").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("leaf") }, icon: { Image(systemName: "leaf.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("heart") }, icon: { Image(systemName: "heart.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("bed") }, icon: { Image(systemName: "bed.double.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("facemask") }, icon: { Image(systemName: "facemask.fill").imageScale(.large) }).labelStyle(.vertical)
//            Label(title: { Text("brain") }, icon: { Image(systemName: "brain").imageScale(.large) }).labelStyle(.vertical)
        }
        .task {
            await self.viewModel.getGenres()
        }
    }
}

extension MainCategoryView {
    class viewModel: ObservableObject {
        @Published private(set) var genres: [Genre] = []
        @Published private(set) var isLoading: Bool = false
        
        func getGenres() async {
            self.isLoading = true
            APIClient.shared.request(GenreResponse.self, router: APIRouter.getGenres) { [weak self] response in
                self?.genres = response.result
                self?.isLoading = false
            } failure: { error in
                print(error.localizedDescription)
            }
        }
    }
}

struct MainCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainCategoryView()
    }
}
