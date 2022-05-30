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
            Label(title: { Text("globe") }, icon: { Image(systemName: "globe.americas.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("flame") }, icon: { Image(systemName: "flame.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("drop") }, icon: { Image(systemName: "drop.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("bolt") }, icon: { Image(systemName: "bolt.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("allergens") }, icon: { Image(systemName: "allergens").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("leaf") }, icon: { Image(systemName: "leaf.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("heart") }, icon: { Image(systemName: "heart.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("bed") }, icon: { Image(systemName: "bed.double.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("facemask") }, icon: { Image(systemName: "facemask.fill").imageScale(.large) }).labelStyle(.vertical)
            Label(title: { Text("brain") }, icon: { Image(systemName: "brain").imageScale(.large) }).labelStyle(.vertical)
        }
    }
}

struct MainCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainCategoryView()
    }
}
