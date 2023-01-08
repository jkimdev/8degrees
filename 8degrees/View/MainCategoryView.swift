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
    let genres: [Genre]
    var columns: [GridItem] = [GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80))]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(self.genres.prefix(7), id: \.id) { genre in
                NavigationLink(destination: {
                    ContentListView(title: genre.code, viewType: .GENRE)
                }, label: {
                    Label(title: { Text(genre.value) }, icon: { Image(systemName: genre.image).imageScale(.large) }).labelStyle(.vertical)
                })
            }
        }
        .padding(.bottom)
    }
}
