//
//  MapVC.swift
//  ImageCity
//
//  Created by Myke Phillips on 16/09/2018.
//  Copyright © 2018 Myke Phillips. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius : Double = 1000

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        configureLocationServices()



    }



    @IBAction func centerMapBtnWasPressed(_ sender: Any) {

        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }

    }

}


extension MapVC: MKMapViewDelegate {

    func centerMapOnUserLocation() {

        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)


    }

}

extension MapVC: CLLocationManagerDelegate {

    func configureLocationServices() {

        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        centerMapOnUserLocation()
    }

}
