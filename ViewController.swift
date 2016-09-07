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
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gesturerecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        
        if activePlace != -1 {
            
            if places.count > activePlace {
                
                if let name = places[activePlace]["name"] {
                    
                    if let lat = places[activePlace]["lat"] {
                        
                        if let lon = places[activePlace]["lon"] {
                            
                            if let latitude = Double(lat) {
                                
                                if let longitude = Double(lon) {
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                                    
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    self.map.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    
                                    annotation.coordinate = coordinate
                                    
                                    annotation.title = name
                                    
                                    self.map.addAnnotation(annotation)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        print("\n The row selected is : \(activePlace)")
        
    }
    
    func longpress(gesturerecognizer: UILongPressGestureRecognizer) {
        
        if gesturerecognizer.state == UIGestureRecognizerState.began {
            
            let touchpoint = gesturerecognizer.location(in: self.map)
            
            let newCoordinate = self.map.convert(touchpoint, toCoordinateFrom: self.map)
            
            // reverse geolocation
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)

            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let placemark = placemarks?[0] {
                        
                        if placemark.subThoroughfare != nil {
                            
                            title += placemark.subThoroughfare! + " "
                            
                        }
                        
                        if placemark.thoroughfare != nil {
                            
                            title += placemark.thoroughfare!
                        }
                    }
                }
                
                if title == "" {
                    
                    title = "Added \(NSDate())"
                }
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.map.addAnnotation(annotation)
                
                places.append(["name":title, "lat": String(newCoordinate.latitude), "lon": String(newCoordinate.longitude)])
                
                print(places)

            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

