//
//  ScheduleViewController.swift
//  RecoveryAI
//
//  Created by Bryan Marks on 2/12/17.
//  Copyright © 2017 Bryan Marks. All rights reserved.
//


import UIKit
import Foundation
import AVKit
import AVFoundation
//import PubNub
//import Alamofire

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var newHeader:[String] = ["Available Times:"]
    @IBOutlet var tableView: UITableView!
    
    var tenDaysfromNow: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 10, to: Date(), options: [])!
    }
    
    var fifteenDaysfromNow: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 15, to: Date(), options: [])!
    }
    
    var twelvefromNow: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 12, to: Date(), options: [])!
    }
    
   
    var descriptionArray:[String] = []
    var  nameArray:[String] = []
    var  videoArray:[String] = []
    
    
    var dummyArray2:[String] = ["One Time Available","Two Times Available" , "One Time Available"]
    
    //    var customInterface: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        getJSONFromServer()
        
        var trackerParametersDictionary: [AnyHashable: Any] = [:]
//        trackerParametersDictionary[kKVAParamAppGUIDStringKey] = "korecoveryai-51f"
//        
//        if let event = KochavaEvent(eventTypeEnum: .custom)
//        {
//            event.userIdString = "ABCDEF12345"
//            //            event.levelString = "1"
//            //            event.scoreString = "15500"
//            event.descriptionString = "pre-approved"
//            event.durationTimeIntervalNumber = 29.0
//        }
        
        
//        let test = convertDateFormater(date:tenDaysfromNow)
//        print("TEST \(test)")
    }
    
    
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return dummyArray2.count
    }
    
    
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.newHeader[0]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Avenir", size: 19)!
        title.textColor = UIColor.black
        
//                let header = view as! UITableViewHeaderFooterView
//                header.textLabel?.font=title.font
//                header.textLabel?.textColor=title.textColor
//                header.textLabel?.textAlignment = NSTextAlignmentCenter
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
 
    
    @IBAction func submitTime(_ sender: Any) {
    
       print("test")
        

    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let ten = String(describing: tenDaysfromNow)
        let newTen = ten.index(ten.startIndex, offsetBy: 10)
        
        let twelve = String(describing: twelvefromNow)
        let newTwelve = twelve.index(twelve.startIndex, offsetBy: 10)
        
        let fifteen = String(describing: fifteenDaysfromNow)
        let newFifteen = fifteen.index(fifteen.startIndex, offsetBy: 10)
        
        var dummyArray:[String] = [ten.substring(to: newTen) + " at 1pm",twelve.substring(to: newTwelve) + " at 3pm and 4pm",fifteen.substring(to: newFifteen) + " at 10am"]
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ScheduleViewCell
        //        cell.textLabel?.text="row#\(indexPath.row)"
        //        cell.detailTextLabel?.text="subtitle#\(indexPath.row)"
        
        
//        cell.textLabel?.numberOfLines = 0
////        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        cell.textLabel?.font = UIFont(name:"Avenir", size:17)
//        
//        cell.textLabel?.text = descriptionArray[indexPath.row]
        //
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 10
        cell.title.text = dummyArray[indexPath.row]
        cell.textLabel?.text = dummyArray2[indexPath.row]
        
      
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Appointment", message: "We'll look into that time and get back to you with a provider!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
//        let submitTime:[String] = ["date"]
//        
//        print("%%%%TEST")
//        
//        //READY FOR CHECHO BACKEND
//        let params: [String: AnyObject] = ["timeSlot": submitTime as AnyObject]
//        let request = Alamofire.request("https://yourServiceURL.com", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
//            
//            switch(response.result) {
//            case .success(_):
//                if response.result.value != nil{
//                    print(response.result.value)
//                }
//                break
//                
//            case .failure(_):
//                print(response.result.error)
//                break
//                
//            }
//        }
//        
//        request.validate()
//        let alert: UIAlertView = UIAlertView(title: "Your Appointment Has Been Requested", message: "Our staff will email and text you soon to confirm your time", delegate: nil, cancelButtonTitle: "Ok");
//        
//        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:50 ,y: 10,width: 37,height: 37)) as UIActivityIndicatorView
//        loadingIndicator.center = self.view.center;
//        loadingIndicator.hidesWhenStopped = false
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//        
//        alert.setValue(loadingIndicator, forKey: "accessoryView")
//        loadingIndicator.startAnimating()
//        
//        alert.show()
//        
//        let refreshAlert = UIAlertController(title: "Your Appointment Has Been Requested", message: "Our staff will email and text you soon to confirm your time.  Are you sure you want to schedule this time?", preferredStyle: UIAlertControllerStyle.alert)
//        
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//            print("Handle Ok logic here")
//        }))
//        
//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
//        
//        present(refreshAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("***#**#*@#*#*@*@*#*#*#@*#@*@#*@")
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        let footerView = UIView(frame:rect)
        footerView.backgroundColor = UIColor.clear
        return footerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
 
//    func getJSONFromServer() {
//        
//        
//        let api = API()
//        let variableString: String = "videos"
//        api.getOrders(section: variableString) { responseObject, error in
//            print("responseObject = \(responseObject); error = \(error)")
//            if let JSON = responseObject {
//                print("JSON is \(JSON)")
//                let found = JSON["data"] as? [AnyObject]
//                print("found is \(found)")
//                for item in found! {
//                    let string = item["description"]!
//                    let name = item["name"]
//                    let video = item["url"]!
//                    print("String is \(string!)")
//                    self.descriptionArray.append(string as! String)
//                    self.nameArray.append(name as! String)
//                    self.videoArray.append(video as! String)
//                    
//                    
//                }
//
//                
//                
//            }  else if error != nil {
//                //                self.newHeader[0] = "Please Connect To The Internet"
//                self.descriptionArray.append(contentsOf: ["*Make sure to allow access in settings!*" ])
//                
//            }
//            self.tableView.reloadData()
//        }
//        
//    }
    
    
    
}
//
//extension String {
//    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//        
//        return boundingBox.height
//    }
//}
//
//extension NSAttributedString {
//    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
//        
//        return boundingBox.height
//    }
//    
//    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
//        
//        return boundingBox.width
//    }
//}
