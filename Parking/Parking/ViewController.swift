//
//  ViewController.swift
//  Parking
//
//  Created by Snehal Mulchandani on 11/9/19.
//  Copyright © 2019 Snehal Mulchandani. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ViewController : UIViewController{
    
    
    @IBOutlet var myMapView: MKMapView!
    @IBAction func searchButton(_ sender: Any) {
         let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.delegate = self as! UISearchBarDelegate
                present(searchController, animated: true, completion: nil)
            }
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
            {
                //Ignoring user
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                //Activity Indicator
                let activityIndicator = UIActivityIndicatorView()
                activityIndicator.style = UIActivityIndicatorView.Style.gray
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.startAnimating()
                
                self.view.addSubview(activityIndicator)
                
                //Hide search bar
                searchBar.resignFirstResponder()
                dismiss(animated: true, completion: nil)
                
                //Create the search request
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = searchBar.text
                
                let activeSearch = MKLocalSearch(request: searchRequest)
                
                activeSearch.start { (response, error) in
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                    {
                        //Remove annotations
                        let annotations = self.myMapView.annotations
                        self.myMapView.removeAnnotations(annotations)
                        
                        //Getting data
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        //Create annotation
                        let annotation = MKPointAnnotation()
                        annotation.title = searchBar.text
                        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.myMapView.addAnnotation(annotation)
                        
                        //Zooming in on annotation
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        self.myMapView.setRegion(region, animated: true)
                    }
                    
                }
            }
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
            }
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            
        }


    
    
    

