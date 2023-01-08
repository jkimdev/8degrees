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
    private let imageHeight: CGFloat = 300
    private let collapsedImageHeight: CGFloat = 75
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                GeometryReader { geo in
                    ZStack {
                        KFImage(URL(string: self.viewModel.performances?.poster ?? ""))
                            .resizable()
                            .overlay (
                                LinearGradient(colors: [.clear, .black.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                            )
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                            .offset(x: 0, y: getOffsetForHeaderImage(geo))
                        
                        //                        Color.black.opacity(0.5)
                        KFImage(URL(string: self.viewModel.performances?.poster ?? ""))
                            .resizable()
                            .cornerRadius(16)
                            .scaledToFit()
                            .frame(width: geo.size.width / 1.5, height: getHeightForHeaderImage(geo) / 1.5 )
                            .clipped()
                            .shadow(color: themeColor, radius: 50)
                    }
                }
                .frame(height: imageHeight)
                VStack(spacing: 24) {
                    HStack {
                        Text(self.viewModel.performances?.title ?? "")
                            .font(.largeTitle)
                        Spacer()
                    }
                    HStack(spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: self.viewModel.performances?.genre.toIcon ?? "")
                            Text("\(Genres(code: self.viewModel.performances?.genre ?? "")?.rawValue ?? "")")
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                        .padding([.horizontal, .vertical], 8)
                        .background(themeColor)
                        .clipShape(Capsule())
                        if self.viewModel.performances?.runtime != "" {
                            Text(self.viewModel.performances?.runtime ?? "")
                                .font(.callout)
                                .foregroundColor(.white)
                                .padding([.horizontal, .vertical], 8)
                                .background(themeColor)
                                .clipShape(Capsule())
                        }
                        Text(self.viewModel.performances?.rating ?? "")
                            .font(.callout)
                            .foregroundColor(.white)
                            .padding([.horizontal, .vertical], 8)
                            .background(themeColor)
                            .clipShape(Capsule())
                        Spacer()
                    }
                    HStack {
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.and.ellipse")
                            Text(self.viewModel.performances?.place ?? "")
                        }
                        Spacer()
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Text("시작일")
                                Text(self.viewModel.performances?.startDate ?? "")
                            }
                            .font(.callout)
                            HStack(spacing: 4){
                                Text("종료일")
                                Text(self.viewModel.performances?.endDate ?? "")
                            }
                            .font(.callout)
                        }
                    }
                    HStack {
                        if let actor = self.viewModel.performances?.actor {
                            ForEach(actor.prefix(3) , id: \.self) { person in
                                Text(person.name == actor.prefix(3).last?.name ? "\(person.name) 등" : person.name)
                            }
                        }
                        Spacer()
                    }
                    VStack {
                        if self.viewModel.performances?.story != "" {
                            Text(self.viewModel.performances?.story ?? "")
                        }
                        else {
                            Text("줄거리를 준비중입니다 😥")
                        }
                    }
                    .font(.body)
                    .lineSpacing(12)
                    .opacity(0.7)
                }
                .foregroundColor(.white)
                .padding([.vertical, .horizontal])
            }
            .onAppear {
                self.viewModel.getPerformance(id: performanceId)
            }
        }
        .background(Color.black.opacity(0.7))
    }
    
    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight
        
        if offset < -sizeOffScreen {
            let imageOffset = abs(min(-sizeOffScreen, offset))
            return imageOffset - sizeOffScreen
        }
        
        return -offset
    }
    
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        let imageHeight = geometry.size.height
        
        return offset > 0 ? imageHeight + offset : imageHeight
    }
    
    func getBlurRaidusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height
        
        return blur * 6
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
