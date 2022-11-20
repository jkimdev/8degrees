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
    @StateObject var viewModel = MapView.ViewModel()
    @StateObject var locationManager = LocationManager()
    @State var isPresented: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: viewModel.facilities) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude,
                                                                 longitude: place.longitude), content: {
                    Circle().frame(width: 15, height: 15).onTapGesture {
                        viewModel.getNearPerformances(facility: place.facilityId, startIdx: "1", endIdx: "15") {
                            if !viewModel.performances.isEmpty {
                                self.isPresented = true
                            }
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
        .sheet(isPresented: $isPresented) {
            PageView(pages: viewModel.performances.map {
                BottomInfoView(performance: $0)}).presentationDetents([.height(200)])
        }
    }
}

extension MapView {
    class ViewModel: ObservableObject {
        @Published var facilities: [Facility] = []
        @Published var performances: [Performance] = []
        @Published var isPresented: Bool = false
        var cancellable = Set<AnyCancellable>()
        
        func getNearFacilities(latitude: Double, longitude: Double) async {
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
        
        func getNearPerformances(facility: String, startIdx: String, endIdx: String, _ completion: @escaping ()-> Void) {
            APIClient.shared.request(PerformanceResponse.self, router: .getPerformanceByFacility(facilityId: facility, startIdx: startIdx, endIdx: endIdx))
                .sink { completion in
                    switch completion {
                    case .finished:
                        return print("get near performances done!")
                    case .failure(let error):
                        return print(error)
                    }
                } receiveValue: { [weak self] response in
                    self?.performances = response.result
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
