//
//  BoxOffice.swift
//  8degrees
//
//  Created by 김재민 on 2022/07/30.
//

import SwiftUI
import Alamofire

struct BoxOfficeView: View {
    @ObservedObject var viewModel: viewModel
    var body: some View {
        
        VStack {
            Text("\(self.viewModel.boxOffices[0].title)")
        }
        .task{
           await self.viewModel.getBoxOffice()
        }
    }
}

extension BoxOfficeView {
    class viewModel: ObservableObject {
        @Published private(set) var boxOffices: [BoxOffice] = []
        
        func getBoxOffice() async {
            APIClient.shared.request(BoxOfficeResponse.self, router: APIRouter.getBoxOffice) { [weak self] response in
                
                self?.boxOffices = response.result
                
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
