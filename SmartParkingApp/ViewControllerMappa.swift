//
//  Mappa.swift
//  ios multiagente
//
//  Created by Gigi Bove on 12/07/15.
//  Copyright (c) 2015 Gigi Bove. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import CoreLocation


class ViewControllerMappa :  UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet var mappa: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    

    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var address : String?
        var price : Double = 0.0
        var latitude : Double = 0.0
        var longitude : Double = 0.0
        var parkingManagerId : String?
        var zone : Int = 0
        var capacity : Int = 0
        var occupied : Int = 0
        var isFull : Bool = false
        var nome : String?
     
        self.mappa.delegate = self
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
     
        let data = richiestaGet("http://www.smile.unina.it/luigicasiello/MAS/test.php")
        let arrayDictionary : NSDictionary = json_parseData(data!)!
        
        for element in arrayDictionary{
            if (element.key as! String) == "address" {
                 address = element.value as? String
            }
            else if (element.key as! String) == "price" {
                
                 price = element.value as! Double
            }
           else if (element.key as! String) == "latitude" {
                 latitude = element.value as! Double
            }
            else if (element.key as! String) == "longitude" {
                 longitude = element.value as! Double
            }
           else if (element.key as! String) == "parkingManagerId" {
                 parkingManagerId = element.value as? String
            }
            else if (element.key as! String) == "zone" {
                 zone = element.value as! Int
            }
            else if (element.key as! String) == "capacity" {
                 capacity = element.value as! Int
            }
            else if (element.key as! String) == "occupied" {
                 occupied = element.value as! Int
            }
            else if (element.key as! String) == "isFull" {
                 isFull = element.value as! Bool
            }
            else if (element.key as! String) == "name" {
                 nome = element.value as? String
            }

        }
       

        //let  location = Geolocalization (longitude : longitude,latitude : latitude)
        let bestparking = ParkingManager(nome: nome!, latitude: latitude, longitude: longitude, address: address!, capacity: capacity, isFull: isFull, occupied: occupied, parkingManagerId: parkingManagerId!, price: price , zone: zone)
        
        
       
         centramappa(bestparking.location)
        
        self.mappa.addAnnotation(bestparking)
        
    

}
 

    func centramappa (location : Geolocalization){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mappa.setRegion(coordinateRegion, animated: true)
        
    }
    
    //metodo che ci permette di fare la richista GET
    func richiestaGet(urlstring : String) -> NSData? {
        //eliminiamo gli spazi dagli attributi
          urlstring.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;

        //impostiamo l'url
        let url = NSURL(string: urlstring)
        //scarichiamo il Json dal server
        if let data = NSData(contentsOfURL: url!) {
            print("[REQUEST] OK!")
            return data
        } else {
            print("[ERROR] There is an unspecified error with the connection")
            return nil
        }
        
    }
    


//trasformiamo il json in un array di NSDictionary
    func json_parseData(data: NSData)  -> NSDictionary? {
        do {
            let json : AnyObject = try(NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers))
            print("[JSON] OK!")
            
            return (json as? NSDictionary);
            
        }catch _{
                
                print("[ERROR] An error has happened with parsing of json data")
                return nil
        }
    
    }

}

    extension ViewControllerMappa  {

    func mapView(mapView: MKMapView,viewForAnnotation annotation: MKAnnotation ) -> MKAnnotationView? {
       
        if let bestParking = annotation as? ParkingManager {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as!  MKPinAnnotationView!
           
            if view == nil {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                view.canShowCallout = true
                view.animatesDrop = false
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = (UIButton (type:UIButtonType.DetailDisclosure)) as UIView
                
            }else {
                
                view.annotation = annotation
            }
            return view
        }
        return nil

    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let bestParking = view.annotation as? ParkingManager{
            if let altertable = bestParking  as? Alertable {
                let alert = altertable.alert()
                alert.addAction(    UIAlertAction (title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                let location = view.annotation as! ParkingManager
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                location.mapItem().openInMapsWithLaunchOptions(launchOptions)
               
            }
            }
            
            
           
            
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "partenza"{
            let passaggio : RaccoltaDatiViewController = segue.destinationViewController as! RaccoltaDatiViewController
            
          
        }
        
    }
}


