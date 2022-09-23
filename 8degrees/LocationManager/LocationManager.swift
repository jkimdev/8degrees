//
//  LocationManager.swift
//  8degrees
//
//  Created by 김재민 on 2022/09/20.
//

import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManger: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    func checkIfLocationServicesIsEnabled() {
        locationManger = CLLocationManager()
        locationManger?.delegate = self
    }
    
    private func checkLocationAuthorization() {
        guard let locationManger = locationManger else { return }
        
        switch locationManger.authorizationStatus {
            
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManger.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
