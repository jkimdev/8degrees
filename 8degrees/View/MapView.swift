//
//  MapView.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/20.
//

import SwiftUI
import CoreLocationUI
import MapKit
import Combine

struct MapView: View {
    @ObservedObject var viewModel = MapView.ViewModel()
    @StateObject var locationManager = LocationManager()
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: viewModel.facilities) { place in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: place.latitude,
                                                             longitude: place.longitude))
            }
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    locationManager.checkIfLocationServicesIsEnabled()
                }
        }.task {
            await viewModel.getNearFacilities(date: "2022-09-22",
                                              latitude: locationManager.locationManger?.location?.coordinate.latitude ?? 0.0,
                                              longitude: locationManager.locationManger?.location?.coordinate.longitude ?? 0.0)
        }
    }
}

extension MapView {
    class ViewModel: ObservableObject {
        @Published var facilities: [Facility] = []
        
        func getNearFacilities(date: String, latitude: Double, longitude: Double) async {
            APIClient.shared.request(FacilityResponse.self, router: .getNearFacility(date: date, latitude: latitude, longitude: longitude)) { [weak self] response in
                self?.facilities = response.result
            } failure: { error in
                print(error.localizedDescription)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
