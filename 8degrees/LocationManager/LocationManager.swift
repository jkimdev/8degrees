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
    var region = MKCoordinateRegion()
    
    @Published var location: CLLocationCoordinate2D?
    func checkIfLocationServicesIsEnabled() {
        locationManger = CLLocationManager()
        locationManger?.delegate = self
        locationManger?.startUpdatingLocation()
    }
    
    func requestLocation() {
        locationManger?.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.location?.latitude ?? 0.0, longitude: self.location?.longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        }
        locationManger?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
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
            requestLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
