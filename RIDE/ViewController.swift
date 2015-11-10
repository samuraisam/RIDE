//
//  ViewController.swift
//  RIDE
//
//  Created by Samuel Sutch on 11/7/15.
//  Copyright © 2015 Samuel Sutch. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var opQ: NSOperationQueue
    var ca: CMAltimeter?
    @IBOutlet var lab: UILabel?
    @IBOutlet var lab2: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        opQ = NSOperationQueue()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            NSLog("relative altimeter is available")
            
            ca = CMAltimeter()
            ca!.startRelativeAltitudeUpdatesToQueue(opQ, withHandler: { (altData, err) -> Void in
                NSLog("altData: \(altData)")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let altData = altData {
                        self.lab?.text = "\(altData.relativeAltitude.description)"
                        self.lab2?.text = "\(altData.pressure.description)"
                    }
                    
                })
            })
            
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        ca?.stopRelativeAltitudeUpdates()
    }

}

