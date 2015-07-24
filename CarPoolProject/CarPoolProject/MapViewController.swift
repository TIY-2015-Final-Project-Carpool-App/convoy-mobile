//
//  MapViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit
import GoogleMaps
import Swift

var chosenAppointmentIndex: Int = 0

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //chosenAppointmentIndex = 0
        
            RailsRequest.session().getUserAppointmentsWithCompletion { () -> Void in
                
                println("this is running")
                var startLatitude = RailsRequest.session().userAppointments[chosenAppointmentIndex]["origin_latitude"] as? Double
                var startLongitude = RailsRequest.session().userAppointments[chosenAppointmentIndex]["origin_longitude"] as? Double
                
                var startPoint = GMSCameraPosition.cameraWithLatitude(startLatitude!, longitude: startLongitude!, zoom: 10)
                
                var camera = startPoint
                var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
                mapView.myLocationEnabled = false
                mapView.indoorEnabled = false
                mapView.addSubview(self.backButton)
                self.view = mapView
                

                if let riders = RailsRequest.session().userAppointments[chosenAppointmentIndex]["riders"] as? [[String:AnyObject]] {
                                        
                    for rider in riders {
                        
                        if let riderInfo = rider["rider"] as? [String:AnyObject], distanceFromOrigin = rider["distance_from_origin"] as? Int, firstName  = riderInfo["first_name"] as? String {
                            
                            if let lat = riderInfo["latitude"] as? Double, lng = riderInfo["longitude"] as? Double {
                                
                                let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                
                                var marker = GMSMarker()
                                marker.position = coord
                                marker.snippet = "\(firstName) is \(distanceFromOrigin) miles from start point"
                                marker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
                                
                                let geocoder = GMSGeocoder()
                                geocoder.reverseGeocodeCoordinate(coord, completionHandler: { (response, error) -> Void in
                                    
                                    let responseResult = response.firstResult().lines
                                    
                                    marker.title = "\(responseResult[0] as! String), \(responseResult[1] as! String)"
                                })
                                
                                marker.map = mapView
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                
                
                let endLatitude = RailsRequest.session().userAppointments[chosenAppointmentIndex]["destination_latitude"] as? Double
                let endLongitude = RailsRequest.session().userAppointments[chosenAppointmentIndex]["destination_longitude"] as? Double
                
                let endMarkerLocation = CLLocationCoordinate2D(latitude: endLatitude!, longitude: endLongitude!)
                let endMarker = GMSMarker(position: endMarkerLocation)
                endMarker.snippet = "End point location"
                endMarker.icon = GMSMarker.markerImageWithColor(UIColor.blackColor())
                
                let startMarkerLocation = CLLocationCoordinate2D(latitude: startLatitude!, longitude: startLongitude!)
                let startMarker = GMSMarker(position: startMarkerLocation)
                startMarker.snippet = "Start point location"
                startMarker.icon = GMSMarker.markerImageWithColor(UIColor.blackColor())
                startMarker.map = mapView
               
                
                let geocoder = GMSGeocoder()
                
                
                
                geocoder.reverseGeocodeCoordinate(endMarkerLocation, completionHandler: { (response, error) -> Void in
                    
                    let responseResult = response.firstResult().lines
                    
                    println(responseResult)
                    
                    println(responseResult[0])
                    
                    endMarker.title = "\(responseResult[0] as! String), \(responseResult[1] as! String)"
                })
                
                
                endMarker.map = mapView
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
