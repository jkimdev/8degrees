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
    @State var isPresented: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: viewModel.facilities) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude,
                                                                 longitude: place.longitude), content: {
                    Circle().onTapGesture {
                        print("print")
                        viewModel.getNearPerformances(facility: place.facilityId, date: "2022-09-01", startIdx: "1", endIdx: "15")
                        if !viewModel.performances.isEmpty {
                            self.isPresented = true
                        }
                    }
                })
            }
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    locationManager.checkIfLocationServicesIsEnabled()
                }
        }.task {
            await viewModel.getNearFacilities(
                latitude: locationManager.locationManger?.location?.coordinate.latitude ?? 0.0,
                longitude: locationManager.locationManger?.location?.coordinate.longitude ?? 0.0)
        }
        .sheetWithDetents(isPresented: $isPresented, dentents: [.medium()], onDismiss: nil) {
            PageView(pages: viewModel.performances.map {UpComingCardView(performance: $0)})
        }
    }
}

extension MapView {
    class ViewModel: ObservableObject {
        @Published var facilities: [Facility] = []
        @Published var performances: [Performance] = []
        
        func getNearFacilities(latitude: Double, longitude: Double) async {
            APIClient.shared.request(FacilityResponse.self, router: .getNearFacility(latitude: latitude, longitude: longitude)) { [weak self] response in
                self?.facilities = response.result
            } failure: { error in
                print(error.localizedDescription)
            }
        }
        
        func getNearPerformances(facility: String, date: String, startIdx: String, endIdx: String) {
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformanceByFacility(facilityId: facility, date: date, startIdx: startIdx, endIdx: endIdx)) { response in
                self.performances = response.result
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
