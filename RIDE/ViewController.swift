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
import SQLite

class ViewController: UIViewController {
    
    var opQ: NSOperationQueue
    var ca: CMAltimeter?
    
    @IBOutlet var ridebg: UIImageView?
    @IBOutlet var mtnfront: UIImageView?
    @IBOutlet var mtnleftbg: UIImageView?
    @IBOutlet var mtnleftmid: UIImageView?
    @IBOutlet var mtnrightbg: UIImageView?
    @IBOutlet var mtnrightmid: UIImageView?
    
    var bgMotionEffect: UIMotionEffectGroup?
    var fgMotionEffect: UIMotionEffectGroup?
    var leftbgMotionEffect: UIMotionEffectGroup?
    var leftmdMotionEffect: UIMotionEffectGroup?
    var rightbgMotionEffect: UIMotionEffectGroup?
    var rightmidMotionEffect: UIMotionEffectGroup?
    
    required init?(coder aDecoder: NSCoder) {
        opQ = NSOperationQueue()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background effect
        let xa = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xa.maximumRelativeValue = NSNumber(float: -20.0)
        xa.minimumRelativeValue = NSNumber(float: 20.0)
        let ya = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        ya.maximumRelativeValue = NSNumber(float: 0)
        ya.minimumRelativeValue = NSNumber(float: -15.0)
        bgMotionEffect = UIMotionEffectGroup()
        bgMotionEffect?.motionEffects = [xa, ya]
        self.ridebg?.addMotionEffect(bgMotionEffect!)

        let xa1 = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xa1.minimumRelativeValue = NSNumber(float: -15.0)
        xa1.maximumRelativeValue = NSNumber(float: 15.0)
        let ya1 = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        ya1.minimumRelativeValue = NSNumber(float: 0)
        ya1.maximumRelativeValue = NSNumber(float: 15)
        fgMotionEffect = UIMotionEffectGroup()
        fgMotionEffect?.motionEffects = [xa1, ya1]
        self.mtnfront?.addMotionEffect(fgMotionEffect!)
        
        let xa2 = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xa2.minimumRelativeValue = NSNumber(float: -20)
        xa2.maximumRelativeValue = NSNumber(float: 20.0)
        let ya2 = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        ya2.minimumRelativeValue = NSNumber(float: -15)
        ya2.maximumRelativeValue = NSNumber(float: 15)
        leftbgMotionEffect = UIMotionEffectGroup()
        leftbgMotionEffect?.motionEffects = [xa2, ya2]
        self.mtnleftbg?.addMotionEffect(leftbgMotionEffect!)
        
        let xa3 = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xa3.minimumRelativeValue = NSNumber(float: -40)
        xa3.maximumRelativeValue = NSNumber(float: 15.0)
        let ya3 = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        ya3.minimumRelativeValue = NSNumber(float: -20)
        ya3.maximumRelativeValue = NSNumber(float: 20)
        leftmdMotionEffect = UIMotionEffectGroup()
        leftmdMotionEffect?.motionEffects = [xa3, ya3]
        self.mtnleftmid?.addMotionEffect(leftmdMotionEffect!)
        
        let xa4 = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xa4.minimumRelativeValue = NSNumber(float: -25.0)
        xa4.maximumRelativeValue = NSNumber(float: 30)
        let ya4 = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        ya4.minimumRelativeValue = NSNumber(float: -30)
        ya4.maximumRelativeValue = NSNumber(float: 10)
        rightbgMotionEffect = UIMotionEffectGroup()
        rightbgMotionEffect?.motionEffects = [xa4, ya4]
        self.mtnrightbg?.addMotionEffect(rightbgMotionEffect!)
        
        let xa5 = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xa5.minimumRelativeValue = NSNumber(float: -40.0)
        xa5.maximumRelativeValue = NSNumber(float: 40.0)
        let ya5 = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        ya5.minimumRelativeValue = NSNumber(float: 30)
        ya5.maximumRelativeValue = NSNumber(float: 5)
        rightmidMotionEffect = UIMotionEffectGroup()
        rightmidMotionEffect?.motionEffects = [xa5, ya5]
        self.mtnrightmid?.addMotionEffect(rightmidMotionEffect!)
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
            })
            
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        ca?.stopRelativeAltitudeUpdates()
    }

}

