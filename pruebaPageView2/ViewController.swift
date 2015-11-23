//
//  ViewController.swift
//  pruebaPageView2
//
//  Created by guitarrkurt on 26/10/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var date = NSDate()
    let formatter = NSDateFormatter()
    var time = String()
    
    var arrayHrMin: NSArray!
    var minuto = String()
    
    var aux = String()
    
    
    var bandera = false
    var min = "35"
    
    
    var player = AVAudioPlayer ()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Ocultar la hora
        UIApplication.sharedApplication().statusBarHidden = true
        formatter.timeStyle = .LongStyle
        //Cambiar el centro del status bar
        let image = UIImage(named: "statusBarTitle.png")
        self.navigationItem.titleView = UIImageView(image: image)
        //Hilo que cambia las imagenes
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        {
            // do your task...
            while(true)
            {
                self.date = NSDate()
                self.time = self.formatter.stringFromDate(self.date)
                self.minuto = self.getMinuto()
                print("min: \(self.minuto)")
                
                dispatch_async(dispatch_get_main_queue())
                {
                    // update some UI...
                    self.clockLabel.text = self.time.substringToIndex(self.time.startIndex.advancedBy(10))

                    if(self.minuto == self.min){

                        print("entro banoInit")
                        self.aux = "bano"
                        self.button.setImage(UIImage(named: "banarInit"), forState: .Normal)
                    }
                }
            }
        }
        //Hilo Notificaciones y Sonidos
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)){
            self.date = NSDate()
            self.time = self.formatter.stringFromDate(self.date)
            self.minuto = self.getMinuto()
            self.bandera = true
            while(true){
                
                if self.minuto == self.min && self.bandera == true{
                
                    
                    
                    
                    self.bandera = false
                    
                    let sound = NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("burbujas", ofType: "mp3")!)
                    do{
                        try self.player = AVAudioPlayer (contentsOfURL: sound)
                    } catch{
                        //CREAMOS UNA VARIABLE PARA GESTIONA ERRORES
                        let error = NSError?()
                        print(error)
                    }
                    self.player.prepareToPlay()
                    self.player.play()
                    
                    
                    
                    let localNotification = UILocalNotification()
                    localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                    localNotification.alertBody = "Hora de bañarse"
                    localNotification.timeZone = NSTimeZone.defaultTimeZone()
                    localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                }
            }
        
        }

    }
    
    
    func getMinuto() -> String{
        self.arrayHrMin = self.time.componentsSeparatedByString(":")
        self.minuto = self.arrayHrMin.objectAtIndex(1) as! String
        self.minuto = self.minuto.substringToIndex(self.minuto.startIndex.advancedBy(2))
        print("Minuto: \(self.minuto)")
        return self.minuto
    }

    @IBAction func buttonAction(sender: UIButton) {
            performSegueWithIdentifier("comerIdentifier", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "comerIdentifier" {
            (segue.destinationViewController as! ComerViewController).aux = aux
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

