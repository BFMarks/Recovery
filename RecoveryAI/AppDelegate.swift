//
//  AppDelegate.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/11/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//

import UIKit
import UserNotifications
//import UserNotifications
//import PubNub
//import "KochavaEvent.h"

//fileprivate let kPushNotificationTokenKey = "PushNotificationTokenKey"
//fileprivate let publishKey = "pub-c-7c7c42ef-2d17-4877-a806-c82605f628f0"
//fileprivate let subscribeKey = "sub-c-6ba7e398-f0c4-11e6-9032-0619f8945a4f"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
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

    
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization
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
        
        // optionally add any push notification channels here
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
     UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Push Notifications
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//  
//    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle error here (most likely a failed certificate or an
        // invalid network connection
    }
    
    // MARK: - PNObjectEventListener
    

    
    
}
