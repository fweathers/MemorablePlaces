//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by Felicia Weathers on 8/30/16.
//  Copyright © 2016 Felicia Weathers. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(activePlace)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

