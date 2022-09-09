//
//  BoxOffice.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/30.
//

import SwiftUI
import Alamofire

struct BoxOfficeView: View {
    @ObservedObject var viewModel = BoxOfficeView.viewModel()
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(self.viewModel.boxOffices, id: \.performanceId) { post in
                            NavigationLink(destination: SingleContentView(performanceId: post.performanceId)) {
                            BoxOfficeCardView(boxOffice: post)
                            }
                        }
                    }.padding()
                }
            }
        }
        .task{
            await self.viewModel.getBoxOffice()
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
        
        func getBoxOffice() async {
            self.isLoading = true
            APIClient.shared.request(BoxOfficeResponse.self, router: APIRouter.getBoxOffices) { [weak self] response in
                
                self?.boxOffices = response.result
                
                self?.isLoading = false
                
            } failure: { error in
                print(error.localizedDescription)
            }
        }
    }
}

struct BoxOfficeView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeView(viewModel: BoxOfficeView.viewModel() )
    }
}
