//
//  ViewController.swift
//  BikeLock
//
//  Created by Mayank Makwana on 4/2/16.
//  Copyright © 2016 Mayank Makwana. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    let unlockButton: UIButton = UIButton()
    let lockButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        
        
        let locationRequest = NSMutableURLRequest(URL: NSURL(string:"https://agent.electricimp.com/B_odmEQnlMF2?LockState=-1")!);
        
        var location = "";
        
        let locationTask = NSURLSession.sharedSession().dataTaskWithRequest(locationRequest) {
            (data, response, error) in
            
            location = (NSString(data: data!, encoding: NSUTF8StringEncoding)?.description)!
            
            print(location)
            
            if(!location.isEmpty)
            {
                var coordinates = location.componentsSeparatedByString(",");
                let initialLocation = CLLocation(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!)
                self.centerMapOnLocation(initialLocation)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!)
                annotation.title = "Bike Location"
                self.mapView.addAnnotation(annotation)
            }
            
        }
        locationTask.resume()
        
        

        
        unlockButton.frame = CGRectMake(65, 30, 100, 50)
        unlockButton.setTitle("Unlock", forState: UIControlState.Normal)
        unlockButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        unlockButton.layer.borderWidth = 1
        unlockButton.layer.cornerRadius = 5
        unlockButton.layer.borderColor = self.view.tintColor.CGColor
        unlockButton.addTarget(self, action: "unlockBike:", forControlEvents: UIControlEvents.TouchUpInside)
    
        lockButton.frame = CGRectMake(185, 30, 100, 50)
        lockButton.setTitle("Lock", forState: UIControlState.Normal)
        lockButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        lockButton.layer.borderWidth = 1
        lockButton.layer.cornerRadius = 5
        lockButton.layer.borderColor = self.view.tintColor.CGColor
        lockButton.addTarget(self, action: "lockBike:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(unlockButton);
        self.view.addSubview(lockButton);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func unlockBike(sender:UIButton!)
    {
        let request = NSMutableURLRequest(URL: NSURL(string:"https://agent.electricimp.com/B_odmEQnlMF2?LockState=1")!);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        task.resume();
        
        print("Bike Unlocked")
    }
    
    func lockBike(sender:UIButton!)
    {
        let request = NSMutableURLRequest(URL: NSURL(string:"https://agent.electricimp.com/B_odmEQnlMF2?LockState=0")!);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        task.resume();
        
        print("Bike Locked")
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}