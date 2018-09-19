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


class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius : Double = 1000

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        configureLocationServices()
        addDoubleTap()



    }

    func addDoubleTap() {

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)



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

    @objc func dropPin(sender: UITapGestureRecognizer) {

        removePin()

        //Drop pin on the map.
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)

        let coordinRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinRegion, animated: true)

    }

    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
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
