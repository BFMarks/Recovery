
//  ApiController.swift
//
//
//  Created by Bryan Marks on 8/8/16.
//  Copyright © 2016 Bryan Marks. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import Mixpanel

var endPoint : String! = "opening"


class API {
    
    var apiEndPoint:String! = "apiEndPoint"
    let apiUrl:String!
    let consumerKey:String!
    let consumerSecret:String!
//    var endPoint : String! = "opening"
    
    
    var returnData = [] as NSArray
    
    init() {
        self.apiUrl = "https://wingboard.herokuapp.com/"
        self.consumerKey = "my consumer key"
        self.consumerSecret = "my consumer secret"
        self.apiEndPoint = "apiEndPoint"
    }
    
    func getOrders(section: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        
        
//        let token = "05096578a308d8c8b4e4cc92ffd949b9"
//        let mixpanel = Mixpanel.sharedInstanceWithToken(token)
        
        //////No member time
        
//        mixpanel.time(event:"Started JSON")
        
        makeCall(section: section, completionHandler: completionHandler)
        print("The current value of getOrders********* is \(section)")
    }

    
    
    func makeCall(section: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
//        let params = ["consumer_key":"key", "consumer_secret":"secret"]
        
       print("The current value of makeCall********* is \(section)")
        
        Alamofire.request( "http://52.52.191.211/patient/\(section)")
        

            .responseJSON { response in
                    print(response)
                    //to get status code
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 201:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                            
                        }
                    }
                    //to get JSON return value
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print("THIS IS *************************** \(JSON)")
                        completionHandler(JSON, nil)
                    }
                    
   }
        
        func makePostRequestForUserSubmission(section: String, completionHandler: (AnyObject?, NSError?) -> ()) {
                  
        }
    
        
        
    }
    
    
    
    
    
}
