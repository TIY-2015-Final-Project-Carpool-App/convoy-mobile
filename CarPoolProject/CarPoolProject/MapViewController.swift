//
//  MapViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var startLatitude = 40.66813955408042
        var startLongitude = -73.93386840820312
        
        var startPoint = GMSCameraPosition.cameraWithLatitude(startLatitude, longitude: startLongitude, zoom: 12)
        
        var camera = startPoint
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = false
        mapView.indoorEnabled = false
        view = mapView
        
        let startMarkerLocation = CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude)
        let startMarker = GMSMarker(position: startMarkerLocation)
        startMarker.snippet = "Start point location"
        startMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        startMarker.map = mapView
        
        
        // run request for 4 from api
        
        // then loop through found locations and do the below code
        var positions = [CLLocationCoordinate2D(latitude: 40.681679, longitude: -73.927002),
                         CLLocationCoordinate2D(latitude: 40.671679, longitude: -73.927002),
                         CLLocationCoordinate2D(latitude: 40.681679, longitude: -73.947002),
                         CLLocationCoordinate2D(latitude: 40.681679, longitude: -73.977002),
                         CLLocationCoordinate2D(latitude: 40.701689458715635, longitude: -73.947001953125),
                         CLLocationCoordinate2D(latitude: 40.651689458715635, longitude: -73.947001953125) ]
        
        for p in positions {
            
            var marker = GMSMarker()
            marker.position = p
            
            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(p, completionHandler: { (response, error) -> Void in
                
                let responseResult = response.firstResult().lines
                
                marker.title = "\(responseResult[0] as! String), \(responseResult[1] as! String)"
            })
            
            marker.map = mapView
            
        }
        
        let endLatitude = 40.681679
        let endLongitude = -73.927002
        
        let endMarkerLocation = CLLocationCoordinate2D(latitude: endLatitude, longitude: endLongitude)
        let endMarker = GMSMarker(position: endMarkerLocation)
        endMarker.snippet = "End point location"
        endMarker.icon = GMSMarker.markerImageWithColor(UIColor.blackColor())
        
        let geocoder = GMSGeocoder()


    
        geocoder.reverseGeocodeCoordinate(endMarkerLocation, completionHandler: { (response, error) -> Void in
        
            let responseResult = response.firstResult().lines
            
            println(responseResult)
            
            println(responseResult[0])
            
            endMarker.title = "\(responseResult[0] as! String), \(responseResult[1] as! String)"
        })
        
//        GoogleDirectionsDefinition *defn = [[GoogleDirectionsDefinition alloc] init];
//        defn.startingPoint =
//        [GoogleDirectionsWaypoint waypointWithQuery:@"221B Baker Street, London"];
//        defn.destinationPoint = [GoogleDirectionsWaypoint
//        waypointWithLocation:CLLocationCoordinate2DMake(51.498511, -0.133091)];
//        defn.travelMode = kGoogleMapsTravelModeBiking;
//        [[OpenInGoogleMapsController sharedInstance] openDirections:defn];
        endMarker.map = mapView
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
