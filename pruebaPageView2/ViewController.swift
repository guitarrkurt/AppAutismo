//
//  ViewController.swift
//  pruebaPageView2
//
//  Created by guitarrkurt on 26/10/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var date = NSDate()
    let formatter = NSDateFormatter()
    var time = String()
    
    var arrayHrMin: NSArray!
    var minuto = String()
    
    var aux = String()
    

    
    override func viewDidLoad()
    {
        UIApplication.sharedApplication().statusBarHidden = true
        super.viewDidLoad()
        formatter.timeStyle = .LongStyle
        
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
                    
                    
                    
                    
                    
                    if(self.minuto == "40"){
                        print("entro banoInit")
                        self.aux = "bano"
                        self.button.setImage(UIImage(named: "banarInit"), forState: .Normal)
                        
                    }
                
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

