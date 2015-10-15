//
//  ViewController.swift
//  ios multiagente
//
//  Created by Gigi Bove on 07/07/15.
//  Copyright (c) 2015 Gigi Bove. All rights reserved.
//

import UIKit
import Foundation



class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var prezzo: UITextField!
    @IBOutlet weak var destinazione: UITextField!
    @IBOutlet weak var partenza: UITextField!
    @IBOutlet weak var cerca: UIButton!
    var coordinateDestinazionePartenza: [String: Double]?
    var latitudineDestinazione: AnyObject?
    var longitudineDestinazione: AnyObject?
    var latitudinePartenza: AnyObject?
    var longitudinePartenza: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinazione.delegate = self
        prezzo.delegate = self
        partenza.delegate = self
        


    }
   
 
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func CercaMethod(sender: UIButton) {
    
        if destinazione.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Si prega di inserire la destinazione", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if prezzo.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Si prega di inserire il prezzo", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if partenza.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message: "Si prega di inserire la partenza", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {

        
            let data =  richiestaGet(urlstring: "http://www.smile.unina.it/luigicasiello/MAS/geocoding.php?destinazione=\(destinazione.text)&partenza=\(partenza.text)")
           
            let arrayDictionary : NSDictionary = json_parseData(data!)!
            
             coordinateDestinazionePartenza =  arrayDictionary as? [String : Double]
           
            print(coordinateDestinazionePartenza);
          


            
    
        }
    }
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        prezzo.resignFirstResponder()
        destinazione.resignFirstResponder()
        partenza.resignFirstResponder()
        view.endEditing(true)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "passaggiodati"{
            let passaggio : RaccoltaDatiViewController = segue.destinationViewController as! RaccoltaDatiViewController
            let tmp = self.destinazione.text
            //passaggio.coordinateDestinazionePartenza = coordinateDestinazionePartenza!
            passaggio.destinazione = tmp
            let tmp1 = self.partenza.text
            passaggio.partenza = tmp1
            
            let tmp3 = self.coordinateDestinazionePartenza
            passaggio.coordinateDestinazionePartenza = tmp3
        }
        
    }
    
    
    
    //metodo che ci permette di fare la richista GET
    func richiestaGet(urlstring urlstring : String) -> NSData? {
        //eliminiamo gli spazi dagli attributi
       
        let urlstring = urlstring.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
        //urlstring.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //impostiamo l'url
         print(urlstring)
        let url = NSURL(string: urlstring)
        //scarichiamo il Json dal server
        if let data = NSData(contentsOfURL: url!) {
            print("[REQUEST1] OK!")
            return data
        } else {
            print("[ERROR] There is an unspecified error with the connection")
            return nil
        }
        
    }
    
    
    
    //trasformiamo il json in un array di NSDictionary
    func json_parseData(data: NSData) -> NSDictionary? {
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




    
 
