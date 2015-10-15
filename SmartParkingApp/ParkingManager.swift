//
//  ParkingManager.swift
//  ios multiagente
//
//  Created by Gigi Bove on 13/07/15.
//  Copyright (c) 2015 Gigi Bove. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

@objc protocol Alertable {
    func alert() -> UIAlertController
}


class ParkingManager : NSObject {
    let nome : String
    let location : Geolocalization
    let address : String
    let capacity : Int
    let isFull : Bool
    let occupied : Int
    let parkingManagerId : String
    let price : Double
    let parkingzone : Int
    
    init (nome:String, location :Geolocalization, address : String, capacity : Int, isFull : Bool, occupied : Int, parkingManagerId : String, price : Double, zone : Int  ){
        
        self.nome = nome
        self.location = location
        self.address  = address
        self.capacity = capacity
        self.isFull  = isFull
        self.occupied = occupied
        self.parkingManagerId = parkingManagerId
        self.price = price
        self.parkingzone = zone
    }
    
    convenience init (nome :String , latitude : Double , longitude : Double,address : String, capacity : Int, isFull : Bool, occupied : Int, parkingManagerId : String, price : Double, zone : Int  ){
        
        let  location = Geolocalization(longitude : longitude,latitude : latitude )
        
        self.init(nome: nome, location: location, address: address, capacity: capacity, isFull: isFull, occupied: occupied, parkingManagerId: parkingManagerId, price: price, zone: zone)
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.address]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        //mapItem.name = self.title
        
        return mapItem
    }
    
}



extension ParkingManager : MKAnnotation{
     var coordinate: CLLocationCoordinate2D {
        return self.location.coordinate
    }
    
    var title: String? {
        return self.nome
    }
}

extension ParkingManager : Alertable {

    func alert() -> UIAlertController {
        let alert = UIAlertController (
            title: "Miglior Parcheggio",
            message: "\(self.nome)\n \(self.address) \n  \(self.price)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
    }
    

}
