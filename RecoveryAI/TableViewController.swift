////
////  TableViewController.swift
////  RecoveryAI
////
////  Created by Bryan Marks on 2/11/17.
////  Copyright © 2017 Bryan Marks. All rights reserved.
////
//
import UIKit
import Foundation
import AVKit
import AVFoundation
import PubNub

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var newHeader:[String] = ["Welcome to Recovery AI"]
    @IBOutlet var tableView: UITableView!

//    var newHeader:[String] = ["Hello Juli"]
    
    var contentArray: Array<String> = ["Plantarflexion - Point your foot down and press your foot on to the top of your other foot. Hold 5 sec. Repeat 10x’s. Do 2-3 sets. ", "Dorsiflexion - With one foot on top of the other, press the foot which is on the bottom up towards the foot on top. Hold 5 sec. Repeat 10x’s. Do 2-3 sets. ", "Inversion - Bring your inner aspect of your foot into the leg of a table. Hold 5 sec. Repeat 10x’s. Do 2-3 sets.","Dorsiflexion - Add active ankle movements during the rolling, such as actively dorsiflexing the foot or performing ankle circles.  . Do 2-3 sets."]
    
    var descriptionArray:[String] = []
    var  nameArray:[String] = []
    var  videoArray:[String] = []
    
//    var customInterface: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

                // Do any additional setup after lo
        //        ading the view, typically from a nib.
//                self.view.addSubview(customInterface)
//        view.addSubview(tableView)
            getJSONFromServer()
          }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return self.contentArray.count
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
        
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font=title.font
//        header.textLabel?.textColor=title.textColor
        //        header.textLabel?.textAlignment = NSTextAlignmentCenter
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
  
//        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        cell.textLabel?.text="row#\(indexPath.row)"
//        cell.detailTextLabel?.text="subtitle#\(indexPath.row)"
        
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name:"Avenir", size:17)
        
        
        
//        cell.textLabel?.text = descriptionArray[indexPath.row]
//
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 10
//        cell.title.text = nameArray[indexPath.row]
        cell.textFieldExercises.text = contentArray[indexPath.row]
        
        
        var logoImage: [UIImage] = [
            UIImage(named: "invesrion.jpeg")!,
            UIImage(named: "plantar.jpeg")!,
            UIImage(named: "eversion.jpeg")!,
            UIImage(named: "dors.jpeg")!
        ]
        
        cell.thumbnail.image = logoImage[indexPath.row]
        
        
        //        let image = UIImage(named: "name") as UIImage?
        
      
        
//        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        button.backgroundColor = .black
//        button.setTitle("Button", for: .normal)
//        button.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
//        cell.addSubview(button)
//        
//        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

            print("Button tapped")

        
        let videoString:String = self.videoArray[indexPath.row]
         let videoURL = NSURL(string: videoString )
        let player = AVPlayer(url: (videoURL as? URL)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        
      
        print("You selected cell #\(indexPath.row)!")
//        let proxy = textDocumentProxy as UITextDocumentProxy
//        let text = self.newArray[indexPath.row]
        
        //        mixpanel.track("Line Used", properties: ["Line Used": text])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    
//    func clearTable() {
//        self.titleArray.removeAll()
//        self.tableView.reloadData()
//        return
//    }
//    
    func getJSONFromServer() {
        //        self.newHeader[0] = "Welcome Juli"
        
        let api = API()
        let variableString: String = "videos"
        api.getOrders(section: variableString) { responseObject, error in
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                print("JSON is \(JSON)")
                let found = JSON["data"] as? [AnyObject]
                print("found is \(found)")
                for item in found! {
                    let string = item["description"]!
                    let name = item["name"]
                    let video = item["url"]!
                    print("String is \(string!)")
//                    self.descriptionArray.append(string as! String)
                    self.nameArray.append(name as! String)
                    self.videoArray.append(video as! String)
                    
                    
                }
                print("DFASJFDASFDDFDFSAFSD")
                
//                self.tableView.reloadData()
            }  else if error != nil {
                //                self.newHeader[0] = "Please Connect To The Internet"
                self.descriptionArray.append(contentsOf: ["*Make sure to allow access in settings!*" ])
                
            }
            self.tableView.reloadData()
        }
        
    }
    
    

//    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
//        // the cells you would like the actions to appear needs to be editable
//        return true
//    }

    
    /////RATING
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "No Affect") { action, index in
            
            
//            print("more button tapped")
//            let progressHUD = ProgressHUD(text: "Sending Feedback")
//            progressHUD.tag = 100
//            self.view.addSubview(progressHUD)
            ///// All done!
//            
//            Timer.scheduledTimer(withTimeInterval: 2, repeats: false){_ in
//                func removeSubview(){
//                    print("Start remove sibview")
//                    if let viewWithTag = self.view.viewWithTag(100) {
//                        viewWithTag.removeFromSuperview()
//                    }else{
//                        print("No!")
//                    }
//                }
//            }
            
        }
        more.backgroundColor = UIColor.lightGray
        
        
        let favorite = UITableViewRowAction(style: .normal, title: "Hurts") { action, index in
            print("favorite button tapped")
//            let progressHUD = ProgressHUD(text: "Sending Feedback")
//            self.view.addSubview(progressHUD)
            // All done!
            
            
        }
        favorite.backgroundColor = UIColor.red
        
        let share = UITableViewRowAction(style: .normal, title: "Helpful") { action, index in
            print("share button tapped")
//            let progressHUD = ProgressHUD(text: "Sending Feedback")
//            self.view.addSubview(progressHUD)
            // All done!
            

        }
        share.backgroundColor = hexStringToUIColor(hex: "#5EBACE")
        
        return [share, favorite, more]
    }
    


}

