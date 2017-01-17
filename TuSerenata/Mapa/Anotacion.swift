//
//  Anotacion.swift
//  TuSerenata
//
//  Created by Bruce on 16/1/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class Anotacion: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
