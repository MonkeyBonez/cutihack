//
//  MapViewController.swift
//  Parking
//
//  Created by Abel Theo on 11/9/19.
//  Copyright © 2019 Snehal Mulchandani. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func Retreat(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "Retreater", sender: self)
    }
    
}
