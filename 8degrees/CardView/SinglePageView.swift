//
//  CarouselView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/29.
//

import SwiftUI

struct CarouselView: View {
    var landmark: Landmark
    
    var body: some View {
        landmark.image
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
        
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(landmark: ModelData().landmarks[0])
    }
}
