//
//  Person.swift
//  Project10
//
//  Created by Denis Sheikherev on 17.05.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
