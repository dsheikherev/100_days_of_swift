//
//  Capital.swift
//  Project16
//
//  Created by Denis Sheikherev on 06.06.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
