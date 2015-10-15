
//
//  GeoLocalization.swift
//  ios multiagente
//
//  Created by Gigi Bove on 13/07/15.
//  Copyright (c) 2015 Gigi Bove. All rights reserved.
//

import Foundation
import MapKit

struct Geolocalization  {
    let longitude : Double
    let latitude : Double
}

extension Geolocalization {
    var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake( self.latitude, self.longitude)
    }
    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(self.coordinate)
    }
}