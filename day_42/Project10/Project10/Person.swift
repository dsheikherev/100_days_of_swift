//
//  Person.swift
//  Project10
//
//  Created by Denis Sheikherev on 17.05.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit

//class Person: NSObject, NSCoding {
//
//    var name: String
//    var image: String
//
//    required init(coder aDecoder: NSCoder) {
//        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
//        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
//    }
//
//    init(name: String, image: String) {
//        self.name = name
//        self.image = image
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(image, forKey: "image")
//    }
//
//}

class Person: Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
