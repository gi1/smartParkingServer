//
//  Prenotazione.swift
//  ios multiagente
//
//  Created by Gigi Bove on 07/09/15.
//  Copyright (c) 2015 Gigi Bove. All rights reserved.
//

import Foundation
import UIKit


class Prenotazione : UIViewController {
  
    @IBOutlet weak var prenotazioneDalleOre: UIDatePicker!
    
    
    @IBOutlet weak var prenotazioneAlleOre: UIDatePicker!
    
    var dalleOreString : NSString = ""
    var alleOreString : NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let dateFormatterDalleOre = NSDateFormatter()
        dateFormatterDalleOre.dateFormat = "dd-MM-yyyy  HH:mm"
        let strDateDalleOre = dateFormatterDalleOre.stringFromDate(prenotazioneDalleOre.date)
        dalleOreString = strDateDalleOre
        
        let dateFormatterAlleOre = NSDateFormatter()
        dateFormatterAlleOre.dateFormat = "dd-MM-yyyy HH:mm"
        let strDateAlleOre = dateFormatterAlleOre.stringFromDate(prenotazioneAlleOre.date)
        alleOreString = strDateAlleOre
        
    }
    
    @IBAction func dalleOreActionMethod(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(prenotazioneDalleOre.date)
        dalleOreString = strDate
        print(strDate)
    }

    @IBAction func alleOreActionMethod(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(prenotazioneAlleOre.date)
        alleOreString = strDate
    }
    
    @IBAction func confermaOrario(sender: AnyObject) {
        /*var alert = UIAlertController(title: "Prenotazione", message: "L'orario di prenotazione è il seguente :\(dalleOreString) , \(alleOreString)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)*/
        
    }
}