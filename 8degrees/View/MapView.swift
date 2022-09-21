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
            
            VStack {
                if let location = locationManager.location {
                    Text("**Current location:** \(location.latitude), \(location.longitude)")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding()
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
                LocationButton {
                    locationManager.requestLocation()
                }
                .frame(width: 180, height: 40)
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
