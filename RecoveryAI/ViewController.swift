//
//  ViewController.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/11/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//
//

//
import UIKit
import PubNub

class ViewController: UIViewController, PNObjectEventListener {
    
//    @IBOutlet weak var textView: UITextView!
  
    
    @IBOutlet weak var slidr: UISlider!
    
    @IBOutlet weak var sliderNum: UILabel!
    @IBAction func slider(_ sender: Any) {
        let currentValue = Int((sender as! UISlider).value)
        
        sliderNum.text = "\(currentValue)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("We should always be able to get the App Delegate")
            
        
        }
        
     
        
        func run(){
        appDelegate.client.publish("It's time for your ", toChannel: "wwdc",
                                                               compressed: false, withCompletion: { (status) in
            
                                            if !status.isError {
            
                                                // Message successfully published to specified channel.
                                            }
                                            else{
            
                                                /**
                                                 Handle message publish error. Check 'category' property to find
                                                 out possible reason because of which request did fail.
                                                 Review 'errorData' property (which has PNErrorData data type) of status
                                                 object to get additional information about issue.
            
                                                 Request can be resent using: status.retry()
                                                 */
                                            }
                    })
        }
        
         run()
        
        test()

//        textView.text = "Loaded!\n"
//        textView.isEditable = false
//        textView.setNeedsLayout()
        
        appDelegate.client.addListener(self)
        appDelegate.client.subscribeToChannels(["my_channel","wwdc"], withPresence: false)
        appDelegate.client.addPushNotificationsOnChannels(["wwdc", "google.io"],
                                                   withDevicePushToken: appDelegate.pushDeviceToken!,
                                                   andCompletion: { (status) in
                                                    
                                                    if !status.isError {
                                                        
                                                        // Handle successful push notification enabling on passed channels.
                                                    }
                                                    else {
                                                        
                                                        /**
                                                         Handle modification error. Check 'category' property
                                                         to find out possible reason because of which request did fail.
                                                         Review 'errorData' property (which has PNErrorData data type) of status
                                                         object to get additional information about issue.
                                                         
                                                         Request can be resent using: status.retry()
                                                         */
                                                    }
        })
        
        
        

        
      
    }
    
    func test(){
        // Handle subscription status change.
        func client(_ client: PubNub, didReceive status: PNStatus) {
            
            if status.operation == .subscribeOperation {
                
                // Check whether received information about successful subscription or restore.
                if status.category == .PNConnectedCategory || status.category == .PNReconnectedCategory {
                    
                    let subscribeStatus: PNSubscribeStatus = status as! PNSubscribeStatus
                    if subscribeStatus.category == .PNConnectedCategory {
                        
                        // This is expected for a subscribe, this means there is no error or issue whatsoever.
                        
                        // Select last object from list of channels and send message to it.
                        let targetChannel = client.channels().last!
                        client.publish("Hello from the PubNub Swift SDK", toChannel: targetChannel,
                                       compressed: false, withCompletion: { (publishStatus) -> Void in
                                        
                                        if !publishStatus.isError {
                                            
                                            // Message successfully published to specified channel.
                                        }
                                        else {
                                            
                                            /**
                                             Handle message publish error. Check 'category' property to find out
                                             possible reason because of which request did fail.
                                             Review 'errorData' property (which has PNErrorData data type) of status
                                             object to get additional information about issue.
                                             
                                             Request can be resent using: publishStatus.retry()
                                             */
                                        }
                        })
                    }
                    else {
                        
                        /**
                         This usually occurs if subscribe temporarily fails but reconnects. This means there was
                         an error but there is no longer any issue.
                         */
                    }
                }
                else if status.category == .PNUnexpectedDisconnectCategory {
                    
                    /**
                     This is usually an issue with the internet connection, this is an error, handle
                     appropriately retry will be called automatically.
                     */
                }
                    // Looks like some kind of issues happened while client tried to subscribe or disconnected from
                    // network.
                else {
                    
                    let errorStatus: PNErrorStatus = status as! PNErrorStatus
                    if errorStatus.category == .PNAccessDeniedCategory {
                        
                        /**
                         This means that PAM does allow this client to subscribe to this channel and channel group 
                         configuration. This is another explicit error.
                         */
                    }
                    else {
                        
                        /**
                         More errors can be directly specified by creating explicit cases for other error categories 
                         of `PNStatusCategory` such as: `PNDecryptionErrorCategory`,  
                         `PNMalformedFilterExpressionCategory`, `PNMalformedResponseCategory`, `PNTimeoutCategory`
                         or `PNNetworkIssuesCategory`
                         */
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    
    // Handle new message from one of channels on which client has been subscribed.
      func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        // Handle new message stored in message.data.message
        if message.data.channel != message.data.subscription {
            
            // Message has been received on channel group stored in message.data.subscription.
        }
        else {
            
            // Message has been received on channel stored in message.data.channel.
        }
        
        print("Received message: \(message.data.message) on channel \(message.data.channel) " +
            "at \(message.data.timetoken)")
    }
    
    // Handle subscription status change.
    func client(_ client: PubNub, didReceive status: PNStatus) {
        
        if status.operation == .subscribeOperation {
            
            // Check whether received information about successful subscription or restore.
            if status.category == .PNConnectedCategory || status.category == .PNReconnectedCategory {
                
                let subscribeStatus: PNSubscribeStatus = status as! PNSubscribeStatus
                if subscribeStatus.category == .PNConnectedCategory {
                    
                    // This is expected for a subscribe, this means there is no error or issue whatsoever.
                }
                else {
                    
                    /**
                     This usually occurs if subscribe temporarily fails but reconnects. This means there was
                     an error but there is no longer any issue.
                     */
                }
            }
            else if status.category == .PNUnexpectedDisconnectCategory {
                
                /**
                 This is usually an issue with the internet connection, this is an error, handle
                 appropriately retry will be called automatically.
                 */
            }
                // Looks like some kind of issues happened while client tried to subscribe or disconnected from
                // network.
            else {
                
                let errorStatus: PNErrorStatus = status as! PNErrorStatus
                if errorStatus.category == .PNAccessDeniedCategory {
                    
                    /**
                     This means that PAM does allow this client to subscribe to this channel and channel group
                     configuration. This is another explicit error.
                     */
                }
                else {
                    
                    /**
                     More errors can be directly specified by creating explicit cases for other error categories
                     of `PNStatusCategory` such as: `PNDecryptionErrorCategory`,
                     `PNMalformedFilterExpressionCategory`, `PNMalformedResponseCategory`, `PNTimeoutCategory`
                     or `PNNetworkIssuesCategory`
                     */
                }
            }
        }
        else if status.operation == .unsubscribeOperation {
            
            if status.category == .PNDisconnectedCategory {
                
                /**
                 This is the expected category for an unsubscribe. This means there was no error in
                 unsubscribing from everything.
                 */
            }
        }
        else if status.operation == .heartbeatOperation {
            
            /**
             Heartbeat operations can in fact have errors, so it is important to check first for an error.
             For more information on how to configure heartbeat notifications through the status
             PNObjectEventListener callback, consult http://www.pubnub.com/docs/ios-objective-c/api-reference#configuration_basic_usage
             */
            
            if !status.isError { /* Heartbeat operation was successful. */ }
            else { /* There was an error with the heartbeat operation, handle here. */ }
        }
    }
    
    @IBAction func pushNotification(_ sender: Any) {
        print("Button tapped")
        
//        appDelegate.client.publish("Hello from the PubNub Swift SDK", toChannel: "my_channel",
//                            compressed: false, withCompletion: { (status) in
//                                
//                                if !status.isError {
//                                    
//                                    // Message successfully published to specified channel.
//                                }
//                                else{
//                                    
//                                    /**
//                                     Handle message publish error. Check 'category' property to find
//                                     out possible reason because of which request did fail.
//                                     Review 'errorData' property (which has PNErrorData data type) of status
//                                     object to get additional information about issue.
//                                     
//                                     Request can be resent using: status.retry()
//                                     */
//                                }
//        })
//        
//        
//        let payloads = ["aps" : ["alert" : "To Apple and PN native devices!"]]
//        self.client.publish(nil, toChannel: "wwdc", mobilePushPayload: payloads,
//                            withCompletion: { (status) in
//                                
//                                print("\(status.debugDescription)")
//        })
//        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
//        textView.text = "Cleared due to memory warning\n"
//        textView.setNeedsLayout()
    }
    
  
    
    // MARK: - PNObjectEventListener
//    
//    func client(_ client: PubNub, didReceive status: PNStatus) {
//        let statusString = "\(status.debugDescription)\n"
//        textView.text = statusString.appending(textView.text)
//        textView.setNeedsLayout()
//    }
//    
//    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
//        let messageString = "\(message.debugDescription)\n"
//        textView.text = messageString.appending(textView.text)
//        textView.setNeedsLayout()
//    }
//    
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
//        let presenceString = "\(event.debugDescription)\n"
//        textView.text = presenceString.appending(textView.text)
//        textView.setNeedsLayout()
    }
    
}
