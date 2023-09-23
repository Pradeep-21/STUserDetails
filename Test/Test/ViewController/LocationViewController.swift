//
//  LocationViewController.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak private var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    
    // MARK: - Init Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        navigationItem.title = kUserLocation
    }
    
    // MARK: - Custom Methods
    
    private func configureMapView() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000 // This is in meters, adjust as needed
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
            @unknown default:
                print("Unknown status")
            }
        }
    }
    
    // CLLocationManagerDelegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            centerMapOnLocation(location: location)
            manager.stopUpdatingLocation() // Optionally stop updating after getting the first location update
        }
    }
        
}
