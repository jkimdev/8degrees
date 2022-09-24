//
//  MapView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/20.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    locationManager.checkIfLocationServicesIsEnabled()
                }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
