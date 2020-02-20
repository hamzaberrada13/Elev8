

//
//  ViewController.swift
//  UserLocationMap
//
//  Created by Stephen Dowless on 1/22/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainScreenViewController: UIViewController {

    // MARK: - Properties
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!

    let centerMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "location-arrow-flat").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        configureMapView()
        enableLocationServices()
    }

    // MARK: - Selectors

    @objc func handleCenterLocation() {
        centerMapOnUserLocation()
        centerMapButton.alpha = 0
    }

    // MARK: - Helper Functions

    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }

    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow

        view.addSubview(mapView)
        mapView.frame = view.frame

        view.addSubview(centerMapButton)
        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -120).isActive = true
        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.layer.cornerRadius = 50 / 2
        centerMapButton.alpha = 0
    }

    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension MainScreenViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.centerMapButton.alpha = 1
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension MainScreenViewController: CLLocationManagerDelegate {

    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location auth status is RESTRICTED")
        case .denied:
            print("Location auth status is DENIED")
        case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        @unknown default:
            fatalError()

        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard locationManager.location != nil else { return }
        centerMapOnUserLocation()
    }
}

