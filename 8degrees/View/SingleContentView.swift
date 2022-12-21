//
//  MainView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/05.
//

import SwiftUI
import Kingfisher
import Combine

struct SingleContentView: View {
    
    @StateObject var viewModel = viewModel()
    @State var barHidden: Bool = true
    var performanceId: String
    let themeColor: Color = Color.random
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ZStack {
                    KFImage(URL(string: self.viewModel.performances?.poster ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                    Color.black.opacity(0.5)
                    KFImage(URL(string: self.viewModel.performances?.poster ?? ""))
                        .resizable()
                        .cornerRadius(16)
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 1.5)
                        .clipped()
                        .shadow(color: themeColor, radius: 50)
                }
            }
            .ignoresSafeArea(edges: .top)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    HStack {
                        Text(self.viewModel.performances?.title ?? "")
                            .font(.largeTitle)
                        Spacer()
                    }
                    HStack {
                        HStack {
                            Image(systemName: self.viewModel.performances?.genre.toIcon ?? "")
                            Text("\(Genres(code: self.viewModel.performances?.genre ?? "")?.rawValue ?? "")")
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                            .padding([.horizontal, .vertical], 8)
                            .background(themeColor)
                            .clipShape(Capsule())
                        Spacer()
                        Text(self.viewModel.performances?.startDate ?? "")
                            .font(.callout)
                    }
                    VStack {
                        if self.viewModel.performances?.story != "" {
                            Text(loremIpsum)
                                .font(.body)
                                .lineSpacing(12)
                                .opacity(0.7)
                        }
                        else {
                            
                        }
                    }
                }
                .foregroundColor(.white)
                .padding([.vertical, .horizontal])
            }
            .background(Color.black.opacity(0.2))
            .onAppear {
                self.viewModel.getPerformance(id: performanceId)
            }
        }
        .background(Color.black.opacity(0.8))
    }
}

extension SingleContentView {
    class viewModel: ObservableObject {
        @Published var performances: Performance?
        @Published var isLoading: Bool = false
        var cancellable = Set<AnyCancellable>()
        
        func getPerformance(id: String) {
            //            self.isLoading = true
            APIClient.shared.request(PerformanceResponse.self, router: APIRouter.getPerformanceById(id: id))
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get content done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.performances = response.result.first
                }
                .store(in: &cancellable)
        }
    }
}

struct SingleContentView_Previews: PreviewProvider {
    static var previews: some View {
        SingleContentView(performanceId: "PF189439")
    }
}

let loremIpsum = "Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis. Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis. Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectcurabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa te dictumst mattis egestas laoreet, cubilia habitant magnis lacinia vivamus etiam aenean."

//                HStack {
//                    Image("person")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 55, height: 55)
//                        .clipShape(Circle())
//                        .shadow(radius: 4)
//
//                    VStack(alignment: .leading) {
//                        Text("Produced By")
//                            .font(.custom("Avenir Next", size: 12))
//                            .foregroundColor(.gray)
//                        HStack {
//                            Text(self.viewModel.performances?.title ?? "")
//                                .font(.custom("Avenir Next", size: 17))
//                            Text(self.viewModel.performances?.startDate ?? "")
//                                .font(.custom("AvenirNext-Regular", size: 12))
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    Spacer()
//                }
