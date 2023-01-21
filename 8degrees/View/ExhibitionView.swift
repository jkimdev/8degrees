//
//  ExhibitionView.swift
//  8degrees
//
//  Created by Jimmy on 2023/01/05.
//

import SwiftUI
import Kingfisher

struct ExhibitionView: View {
    let exhibition: Exhibition
    var body: some View {
        NavigationLink {
            ExhibitionDetailView(exhibition: exhibition)
        } label: {
            KFImage(URL(string: exhibition.poster)!)
                .centerCropped()
        }
    }
}

//struct ExhibitionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExhibitionView(exhibition: BoxOffice(performanceId: "1", ranking: 1, title: "개인 사진전", genre: "전시", poster: "", story: nil))
//    }
//}
