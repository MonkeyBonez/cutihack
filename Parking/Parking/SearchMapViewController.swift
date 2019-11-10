//
//  SearchMapView.swift
//  Parking
//
//  Created by Harshul Mulchandani on 11/9/19.
//  Copyright © 2019 Snehal Mulchandani. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SearchMapViewController : UIViewController, UISearchBarDelegate, MKMapViewDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view, typically from a nib.
           searchBar.delegate = self
        mapView.delegate = self
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let address = searchBar.text else { return }
        
        getCoordinate(addressString: address, completionHandler: zoomToCoordinate(location:error:))
        
    }
    
    func getCoordinate( addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                    
                completionHandler(location.coordinate, nil)
                return
            }
        }
            
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    func zoomToCoordinate(location: CLLocationCoordinate2D, error: NSError? = nil) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude  , longitude: location.longitude)
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let searchText = searchBar.text else { return }
        if(searchText.lowercased().contains("blazewood")) {
            self.performSegue(withIdentifier: "toConfirmation", sender: self)
        } else {
            self.performSegue(withIdentifier: "toDetailedLotInfo", sender: self)
        }
    }
    
    
}
