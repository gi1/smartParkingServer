//
//  RaccoltaDatiViewController.swift
//  ios multiagente
//
//  Created by Gigi Bove on 15/07/15.
//  Copyright (c) 2015 Gigi Bove. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class RaccoltaDatiViewController : UIViewController {

    
    @IBOutlet weak var tempoDiPercorrenza: UISlider!
    @IBOutlet weak var sliderPrezzo: UISlider!
    @IBOutlet weak var sliderDistanza: UISlider!
    @IBOutlet weak var livelloUtilita: UILabel!
    @IBOutlet weak var sliderSoglia: UISlider!
    
    var coordinateDestinazionePartenza:[String:Double]? = nil
    
    var prezzo : Float = 0.0
    var distanza : Float = 0.0
    var tempo : Float = 0.0
    var soglia : Float = 0.0
    var destinazione : String!
    var partenza : String!
    
  
  
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
    }
    
    @IBAction func valoreUtilitaPrezzo(sender: UISlider) {
        
        prezzo = sliderPrezzo.value
        
    }
    
    @IBAction func valoreTempoDipercorrenza(sender: UISlider) {
        tempo = tempoDiPercorrenza.value
        
    }
    @IBAction func valoreUtilitaDistanza(sender: AnyObject) {
        distanza = sliderDistanza.value

        
    }
    
    @IBAction func valoreUtilitaSoglia(sender: UISlider) {
        soglia = sliderSoglia.value
    }
    
    @IBAction func recuperaDati(sender: UIButton) {

        let latitudinedestinazione  = coordinateDestinazionePartenza!["latitudineDestinazione"]!;
        let latitudinePartenza = coordinateDestinazionePartenza!["latitudinePartenza"]!;
        let longitudineDestinazione  = coordinateDestinazionePartenza!["longitudineDestinazione"]!;
        let longitudinePartenza  = coordinateDestinazionePartenza!["longitudinePartenza"]!;
       
        let jsonString = "requestJson=[{\"prezzo\":\(prezzo/4),\"tempo\":\(tempo/4),\"distanza\": \(distanza/4),\"partenza\":[\(latitudinePartenza),\(longitudinePartenza)],\"arrivo\"[\(latitudinedestinazione),\(longitudineDestinazione)],\"soglia\": \(soglia/4)}]"
        print(jsonString)
    }
    
    
  
    func inviareJsonPOST (jsonString jsonString : String)throws -> ObjCBool{
        let url = NSURL (string:jsonString)
        let request = NSMutableURLRequest(URL : url!)
                request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        request.HTTPMethod = "POST"
        var response: NSURLResponse?
        do {
            NSURLSession.sharedSession().dataTaskWithRequest(request)
            if let httpResponse = response as? NSHTTPURLResponse {
                print("HTTP response: \(httpResponse.statusCode)")
                return true
            } else {
                print("No HTTP response")
                return false
            }

        }catch _{
            
            print("[ERROR] An error has happened with parsing of json data")
        }


        
    }
}