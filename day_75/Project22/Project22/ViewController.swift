//
//  ViewController.swift
//  Project22
//
//  Created by Denis Sheikherev on 18.06.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var distanceReading: UILabel!
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 1, minor: 1, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
                case .far:
                    self.view.backgroundColor = .blue
                    self.distanceReading.text = "FAR"
                case .near:
                    self.view.backgroundColor = .orange
                    self.distanceReading.text = "NEAR"
                case .immediate:
                    self.view.backgroundColor = .red
                    self.distanceReading.text = "RIGHT HERE"
                default:
                    self.view.backgroundColor = .gray
                    self.distanceReading.text = "UNKNOWN"
            }
        }
    }

}

