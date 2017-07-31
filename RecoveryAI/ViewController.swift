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
import EventKit
import UserNotifications
//import PubNub

class ViewController: UIViewController {
    
    
    @IBOutlet weak var slidr: UISlider!
    
    @IBOutlet weak var sliderNum: UILabel!
    @IBAction func slider(_ sender: Any) {
        let currentValue = Int((sender as! UISlider).value)
        
        sliderNum.text = "\(currentValue)"
        
        self.sliderNumber = currentValue
        
    }
    
    var sliderNumber = 2
    
    func test() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Exercises Reminder", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello time to do your exercises :)", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber;
        content.categoryIdentifier = "com.elonchan.localNotification"
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 60.0, repeats: true)
        let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    
  
    
    @IBAction func setReminder(_ sender: Any) {
        test()
        
        var aDay = "Twice"
        
        if sliderNumber == 0 {
            print("slider 0")
            aDay = "No Exercise"
        } else if sliderNumber == 1 {
            aDay = "Once"
        } else if sliderNumber == 2 {
            print("slider 2")
            aDay = "Twice"
        } else if sliderNumber == 3 {
            print("slider 3")
            aDay = "Three Times"
        } else if sliderNumber == 4 {
            print("slider 4")
            aDay = "Four Times"
        } else if sliderNumber == 5 {
            print("slider 5")
        } else {
            print("shit broke")
        }
        
        let alert = UIAlertController(title: "Reminder", message: "Your Reminder Has Been Set For \(aDay) A Day!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
