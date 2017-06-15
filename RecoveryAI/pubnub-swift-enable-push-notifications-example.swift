//
//  pubnub-swift-enable-push-notifications-example.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/11/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//

import Foundation
import PubNub

var client: PubNub?

// Configure PubNub client instance
let configuration = PNConfiguration(publishKey: "demo-36", subscribeKey: "demo-36")
self.client = PubNub.clientWithConfiguration(configuration)

self.client?.addPushNotificationsOnChannels(["wwdc", "google.io"],
                                            withDevicePushToken: self.devicePushToken,
                                            andCompletion: { (status) -> Void in
                                                
                                                if !status.error {
                                                    
                                                    // Handle successful push notification enabling on passed channels.
                                                }
                                                else {
                                                    
                                                    // Handle modification error. Check 'category' property
                                                    // to find out possible reason because of which request did fail. 
                                                    // Review 'errorData' property (which has PNErrorData data type) of status 
                                                    // object to get additional information about issue.
                                                    //
                                                    // Request can be resent using: status.retry()
                                                }
})
