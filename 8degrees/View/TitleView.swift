//
//  TitleView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/29.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("8Degrees").font(.bold(size: 32)).padding(.leading)
            Spacer()
            NavigationLink(destination: {
                MapView()
            }, label: {
                HStack {
                    Text("내 주변").font(.regular(size: 16))
                    Image(systemName: "safari.fill").imageScale(.large).padding(.trailing)
                }
            })
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
