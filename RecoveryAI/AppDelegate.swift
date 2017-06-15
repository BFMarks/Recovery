//
//  AppDelegate.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/11/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//

import UIKit
import UserNotifications
import PubNub
//import "KochavaEvent.h"

fileprivate let kPushNotificationTokenKey = "PushNotificationTokenKey"
fileprivate let publishKey = "pub-c-7c7c42ef-2d17-4877-a806-c82605f628f0"
fileprivate let subscribeKey = "sub-c-6ba7e398-f0c4-11e6-9032-0619f8945a4f"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {
    
    public private(set) var pushDeviceToken: Data? = UserDefaults.standard.object(forKey: kPushNotificationTokenKey) as! Data? {
        willSet {
            // If there is an old non nil value then let's remove that push token from all channels
            if let actualOldToken = pushDeviceToken, pushDeviceToken != newValue {
                self.client.removeAllPushNotificationsFromDeviceWithPushToken(actualOldToken, andCompletion: { (status) in
                    // confirm the push token was removed
                })
            }
        }
        didSet {
            UserDefaults.standard.set(pushDeviceToken, forKey: kPushNotificationTokenKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var window: UIWindow?
    
    lazy var client: PubNub = {
        // insert your keys here
        let config = PNConfiguration(publishKey: publishKey, subscribeKey: subscribeKey)
        let createdClient = PubNub.clientWithConfiguration(config)
        // optionally add the app delegate as a listener, or anything else
        // View Controllers should get the client from the App Delegate
        // and add themselves as listeners if they are interested in
        // stream events (subscribe, presence, status)
        createdClient.addListener(self)
        return createdClient
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
                    // You might want to remove this, or handle errors differently in production
                    assert(error == nil)
                    if granted {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                })
            case .authorized:
                UIApplication.shared.registerForRemoteNotifications()
            case .denied:
                let useNotificationsAlertController = UIAlertController(title: "Turn on notifications", message: "This app needs notifications turned on for the best user experience", preferredStyle: .alert)
                let goToSettingsAction = UIAlertAction(title: "Go to settings", style: .default, handler: { (action) in
                    
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .default)
                useNotificationsAlertController.addAction(goToSettingsAction)
                useNotificationsAlertController.addAction(cancelAction)
                self.window?.rootViewController?.present(useNotificationsAlertController, animated: true)
            }
        }
        
        
//        let test = KochavaTracker.shared
        
        // trackerParametersDictionary
        var trackerParametersDictionary: [AnyHashable: Any] = [:]
        trackerParametersDictionary[kKVAParamAppGUIDStringKey] = "korecoveryai-51f"
        trackerParametersDictionary[kKVAParamRetrieveAttributionBoolKey] = true;
        
        // KochavaTracker.shared
         KochavaTracker.shared.configure(withParametersDictionary: trackerParametersDictionary, delegate: self as? KochavaTrackerDelegate)
        
        
        if let event = KochavaEvent(eventTypeEnum: .registrationComplete)
        {
            event.userIdString = "ABCDEF12345"
//            event.levelString = "1"
//            event.scoreString = "15500"
            event.descriptionString = "pre-approved"
            event.durationTimeIntervalNumber = 65.0
        }

        
        
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        return true
    }
    


    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // This is where you should unsubscribe
        self.client.unsubscribeFromAll()
        // optionally add any push notification channels here
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // This is the best place to begin resubscribing to any important channels
        let channels = [
            "a",
            ]
        self.client.subscribeToChannels(channels, withPresence: true)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Push Notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken: \(deviceToken)")
        self.pushDeviceToken = deviceToken
        if let actualDeviceToken = self.pushDeviceToken {
            // Add any push tokens to channels on app did finish launching
            let pushChannels = ["a"]
            self.client.addPushNotificationsOnChannels(pushChannels, withDevicePushToken: actualDeviceToken, andCompletion: { (status) in
                // Confirm push token addition
            })
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle error here (most likely a failed certificate or an
        // invalid network connection
    }
    
    // MARK: - PNObjectEventListener
    
    func client(_ client: PubNub, didReceive status: PNStatus) {
        // This is a good place to deal with unexpected status messages like
        // network failures
    }
    
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        // This most likely won't be used here, but in any relevant view controllers
        print("Message: \(message.debugDescription)")
    }
    
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        // This most likely won't be used here, but in any relevant view controllers
    }
    
    
}
