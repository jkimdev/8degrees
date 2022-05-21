//
//  ContentView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    
    private let imageHeight: CGFloat = 300 // 1
    private let collapsedImageHeight: CGFloat = 75 // 2
    @State var barHidden: Bool = true

    // 1
    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    // 2
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight // 3
        
        if offset < -sizeOffScreen {
            // Since we want 75 px fixed on the screen we get our offset of -225 or anything less than. Take the abs value of
            let imageOffset = abs(min(-sizeOffScreen, offset))
            
            // Now we can the amount of offset above our size off screen. So if we've scrolled -250px our size offscreen is -225px we offset our image by an additional 25 px to put it back at the amount needed to remain offscreen/amount on screen.
            return imageOffset - sizeOffScreen
        }
        
        // Image was pulled down
        if offset > 0 {
            return -offset
        }
        
        return 0
    }
    
    private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height
        
        if offset > 0 {
            return imageHeight + offset
        }
        
        return imageHeight
    }
    
    private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        // 2
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
        return blur * 6 // Values will range from 0 - 6
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                GeometryReader { geo in
                    Image("rollingstone")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: self.getHeightForHeaderImage(geo))
                        .blur(radius: getBlurRadiusForImage(geo))
                        .clipped()
                        .offset(y: getOffsetForHeaderImage(geo))
                }.frame(height: 300)
                
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
                            Text("Jaemin Kim")
                                .font(.custom("Avenir Next", size: 17))
                        }
                    }
                    Text("15 May 2022 • 5 min read")
                        .font(.custom("AvenirNext-Regular", size: 12))
                        .foregroundColor(.gray)
                    
                    Text("How to build a parallax scroll view")
                        .font(.custom("Avenir Next", size: 28))
                    Text(loremIpsum)
                        .font(.custom("AvenirNext-Regular", size: 17))
                        
                }
                .padding(.horizontal)
                .padding(.top, 16.0)
            }
            .ignoresSafeArea(edges: .top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "arrow.backward").foregroundColor(.white)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Image(systemName: "hands.clap")
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let loremIpsum = "Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis. Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis. Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectcurabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa te dictumst mattis egestas laoreet, cubilia habitant magnis lacinia vivamus etiam aenean."
