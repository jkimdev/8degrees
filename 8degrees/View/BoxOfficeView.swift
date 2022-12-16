//
//  BoxOffice.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/30.
//

import SwiftUI
import Alamofire
import Combine

struct BoxOfficeView: View {
    @StateObject var viewModel = viewModel()
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("🎬 금주의 TOP 10").font(.bold(size: 18)).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(self.viewModel.boxOffices, id: \.performanceId) { post in
                            NavigationLink(destination: SingleContentView(performanceId: post.performanceId)) {
                                BoxOfficeCardView(boxOffice: post)
                            }
                        }
                    }.padding([.horizontal, .bottom])
                }
            }
        }
        .onAppear {
            self.viewModel.getBoxOffice()
        }
        .overlay{
            self.viewModel.isLoading ? ProgressView(value: 0)
                .progressViewStyle(CircularProgressViewStyle(tint: .red)) : nil
        }
    }
}

extension BoxOfficeView {
    class viewModel: ObservableObject {
        @Published private(set) var boxOffices: [BoxOffice] = []
        @Published private(set) var isLoading: Bool = false
        var cancellable = Set<AnyCancellable>()
        
        func getBoxOffice() {
            //            self.isLoading = true
            APIClient.shared.request(BoxOfficeResponse.self, router: APIRouter.getBoxOffices)
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get boxoffice done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.boxOffices = response.result
                }
                .store(in: &cancellable)
        }
    }
}

struct BoxOfficeView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeView(viewModel: BoxOfficeView.viewModel() )
    }
}
