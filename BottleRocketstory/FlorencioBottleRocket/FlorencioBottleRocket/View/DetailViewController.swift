//
//  DetailViewController.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/6/22.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    var location: Location?

    @IBOutlet private weak var restaurantMapKit: MKMapView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantCategoryLabel: UILabel!
    @IBOutlet private weak var restaruatnAddresslabel: UILabel!
    @IBOutlet private weak var restaurantAdderssLabel2: UILabel!
    @IBOutlet private weak var phoneNumberlabel: UILabel!
    @IBOutlet private weak var twitterHandleLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private let userRadiusInMeters: Double = 1000
    
    var restaurantName = ""
    var restaurantCategory = ""
    var formatedAddress = ["", ""]
    var formatedPhone = ""
    var twitterHandle = ""
    var long = 0.0
    var lat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateView()
        displayOnMap(latitude: lat, longitude: long)
        
    }
    
    private func populateView() {
        title = "Lunch Tyme"
        restaurantMapKit.delegate = self
        restaurantNameLabel.text = restaurantName
        restaurantCategoryLabel.text = restaurantCategory
        restaruatnAddresslabel.text = formatedAddress[0]
        restaurantAdderssLabel2.text = formatedAddress[1]
        phoneNumberlabel.text = formatedPhone
        twitterHandleLabel.text = twitterHandle
    }
    
    private func displayOnMap(latitude: Double, longitude: Double) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.title = restaurantName
        annotation.coordinate = location
        restaurantMapKit.addAnnotation(annotation)
        grokLocation(location)
    }
    
    private func grokLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 2000, longitudinalMeters: 2000)
        restaurantMapKit.setRegion(region, animated: true)
    }
}
