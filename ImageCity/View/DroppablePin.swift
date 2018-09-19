//
//  DroppablePin.swift
//  ImageCity
//
//  Created by Myke Phillips on 19/09/2018.
//  Copyright © 2018 Myke Phillips. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {

    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String

    init(coordinate: CLLocationCoordinate2D, identifier: String) {

        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }





}
