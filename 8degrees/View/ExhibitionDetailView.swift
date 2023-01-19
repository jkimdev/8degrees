//
//  ExhibitionDetailView.swift
//  8degrees
//
//  Created by Jimmy on 2023/01/17.
//

import SwiftUI
import Kingfisher

struct ExhibitionDetailView: View {
    let exhibition: Exhibition
    var body: some View {
        VStack {
            KFImage(URL(string: exhibition.poster))
                .centerCropped()
                .frame(height: 200)
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    Text(exhibition.title)
                        .font(.largeTitle)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(exhibition.place)
                        Text(exhibition.area)
                        Spacer()
                        Link(destination: URL(string: exhibition.link)!) {
                            Image("instagram")
                        }
                    }
                    .font(.callout)
                    VStack(spacing: 4) {
                        HStack(spacing: 4) {
                            Text("시작일")
                            Text(self.exhibition.startDate)
                        }
                        .font(.callout)
                        HStack(spacing: 4){
                            Text("종료일")
                            Text(self.exhibition.endDate)
                        }
                        .font(.callout)
                    }
                }
                Spacer()
            }
            .padding()
            ScrollView(showsIndicators: false) {
                HStack {
                    Text(exhibition.story)
                        .font(.body)
                    Spacer()
                }
                .padding([.horizontal, .bottom])
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ExhibitionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionDetailView(exhibition: Exhibition(performanceId: "1", ranking: 1, title: "임하람 개인전", genre: "개인전시", poster: "https://github.com/jkimdev/privacy/blob/main/KakaoTalk_Photo_2023-01-17-21-15-56%20copy.jpg?raw=true", story: "제주 내에서 왕성한 활동을 진행 중인 임하람 작가는 몇 년간 작업을 하며 사진을 찍는 이유와 자신의 존재에 대해 깊은 고찰을 했다. 그리고 그 답을 찾기 위해 첫 번째 개인전 \'ME\'를 준비했다.", area: "제주", place: "심헌 갤러리", startDate: "2023-01-23", endDate: "2023-01-24", link: "https://"))
    }
}
