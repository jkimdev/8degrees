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
    private let locationManger = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    override init() {
        super.init()
        locationManger.delegate = self
    }
    
    func requestLocation() {
        locationManger.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
