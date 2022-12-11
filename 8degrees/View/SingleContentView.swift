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
    
    @StateObject var viewModel = SingleContentView.viewModel()
    @State var barHidden: Bool = true
    var performanceId: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            KFImage(URL(string: self.viewModel.performances?.poster ?? ""))
                .centerCropped()
                .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    
                    // 2
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                    
                    // 3
                    VStack(alignment: .leading) {
                        Text("Article Written By")
                            .font(.custom("Avenir Next", size: 12))
                            .foregroundColor(.gray)
                        Text(self.viewModel.performances?.title ?? "")
                            .font(.custom("Avenir Next", size: 17))
                    }
                }
                Text(self.viewModel.performances?.startDate ?? "")
                    .font(.custom("AvenirNext-Regular", size: 12))
                    .foregroundColor(.gray)
                
                Text("How to build a parallax scroll view")
                    .font(.custom("Avenir Next", size: 28))
                Text(self.viewModel.performances?.story ?? "")
                    .font(.custom("AvenirNext-Regular", size: 17))
                
            }
            .padding(.horizontal)
            .padding(.top, 16.0)
        }.ignoresSafeArea(edges: .top)
            .onAppear {
                self.viewModel.getPerformance(id: performanceId)
            }
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
                        return print("get boxoffice done!")
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
