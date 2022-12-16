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
import PopupView

struct MapView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var locationManager = LocationManager()
    @State var isPresented: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: viewModel.facilities) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude,
                                                                 longitude: place.longitude), content: {
                    NavigationLink {
                        ContentListView(facilityId: place.facilityId , title: place.place, viewType: .SEARCH)
                    } label: {
                        Circle().frame(width: 15, height: 15)
                    }

//                        .onTapGesture {
//                            if !viewModel.performances.isEmpty {
//                                self.isPresented = true
//                            }
//                            viewModel.getNearPerformances(facility: place.facilityId, startIdx: "1", endIdx: "15")
//                        }
                })
            }
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    locationManager.checkIfLocationServicesIsEnabled()
                }
        }
        .onAppear {
            viewModel.getNearFacilities(
                latitude: locationManager.locationManger?.location?.coordinate.latitude ?? 0.0,
                longitude: locationManager.locationManger?.location?.coordinate.longitude ?? 0.0)
        }
    }
}

extension MapView {
    class ViewModel: ObservableObject {
        @Published var facilities: [Facility] = []
        @Published var isPresented: Bool = false
        var cancellable = Set<AnyCancellable>()
        
        func getNearFacilities(latitude: Double, longitude: Double) {
            APIClient.shared.request(FacilityResponse.self, router: .getNearFacility(latitude: latitude, longitude: longitude))
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get near facilities done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.facilities = response.result
                }
                .store(in: &cancellable)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
