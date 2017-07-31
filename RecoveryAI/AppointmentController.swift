//
//  AppointmentController.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/12/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//

import UIKit
//import PubNub

class AppointmentController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var trackerParametersDictionary: [AnyHashable: Any] = [:]
        trackerParametersDictionary[kKVAParamAppGUIDStringKey] = "korecoveryai-51f"
        
        if let event = KochavaEvent(eventTypeEnum: .custom)
        {
            event.userIdString = "ABCDEF12345"
            //            event.levelString = "1"
            //            event.scoreString = "15500"
            event.descriptionString = "reminder"
            event.durationTimeIntervalNumber = 29.0
        }
        
        }

    
}
