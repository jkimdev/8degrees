//
//  MainCategoryView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/26.
//

import SwiftUI

struct MainCategoryView: View {
    
    var columns: [GridItem] = [GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                               GridItem(.fixed(80)),
                            GridItem(.fixed(80))]

    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 10) {
            Label(title: { Text("Hello") }, icon: { Image(systemName: "person") }).labelStyle(.vertical)
            Label(title: { Text("Hello") }, icon: { Image(systemName: "person") }).labelStyle(.vertical)
            Label(title: { Text("Hello") }, icon: { Image(systemName: "person") }).labelStyle(.vertical)
            Label(title: { Text("Hello") }, icon: { Image(systemName: "person") }).labelStyle(.vertical)
            Label(title: { Text("Hello") }, icon: { Image(systemName: "person") }).labelStyle(.vertical)
            Label(title: { Text("Hello") }, icon: { Image(systemName: "person") }).labelStyle(.vertical)
        }
    }
}

struct MainCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainCategoryView()
    }
}
