//  RailsRequest.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.


import UIKit
import Foundation

private let defaults = NSUserDefaults.standardUserDefaults()
private let singleton = RailsRequest()

class RailsRequest: NSObject {
    
    class func session() -> RailsRequest { return singleton }
    
    let API_URL = "https://ancient-sea-7341.herokuapp.com"
    
    var token: String? {
        
        get {
            
            return defaults.objectForKey("TOKEN") as? String
        }
        
        set {
            
            defaults.setValue(newValue, forKey: "TOKEN")
            defaults.synchronize()
        }
    }
    
    var id: Int? {
        
        get {
            return defaults.objectForKey("ID") as? Int
        }
        
        set {
            defaults.setValue(newValue, forKey: "ID")
            defaults.synchronize()
        }
    }
    
    var givenUser: String? {
        
        get {
            return defaults.objectForKey("USERNAME") as? String
        }
        
        set {
            defaults.setValue(newValue, forKey: "USERNAME")
            defaults.synchronize()
        }
    }
    
    var childIds: [[String:AnyObject]] = [[:]]
    var contactIds: [[String:AnyObject]] = [[:]]
    var carpools: [[String:AnyObject]] = [[:]]
    var invites: [[String:AnyObject]] = [[:]]
    
    var username = ""
    var password = ""
    var firstName = ""
    var lastName = ""
    var email = ""
    var address = ""
    var phoneNumber = ""
    var avatar = ""
    var ogUsername = ""
    
    var usernameLabel = ""
    var firstnameLabel = ""
    var lastnameLabel = ""
    var addressLabel = ""
    var emailLabel = ""
    var phoneLabel = ""
    
    var dob = ""
    var height = 1
    var weight = 1
    
    var conditions = ""
    var medications = ""
    var notes = ""
    var allergies = ""
    var insurance = ""
    var religiousPreference = ""
    var bloodType = ""
    
    var relationship = ""
    var altNumber = ""
    
    var title = ""
    var descript = ""
    
//    var joinedToken = ""
    
    ////////////////////////////////////////////////////////////// POST
    
    func registerWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users",
            "parameters" : [
                
                "username" : username, // required
                "password" : password, // required
                "first_name" : firstName, // required
                "last_name" : lastName, // required
                "email" : email, // required
                "address" : address,
                "phone_number" : phoneNumber,
                "avatar" : avatar
                
                
            ]
            
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("\(responseInfo)")
            
            if let userInfo = responseInfo as [String:AnyObject]? {
                if let insideUserInfo = userInfo["user"] as? [String:AnyObject] {
                    if let accessToken = insideUserInfo["access_token"] as? String {
                        println("access token established, run completion")
                        self.token = accessToken
                        completion()
                    }
                }
            }
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
                if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let userId = insideUserIdInfo["id"] as? Int {
                        println("id established")
                        self.id = userId
                    }
                }
            }
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
                if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let username = insideUserIdInfo["username"] as? String {
                        println("username stored")
                        self.givenUser = username
                    }
                }
            }
        })
    }
    
    func loginWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "username" : username,
                "password" : password
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            
            println("\(responseInfo)")
            
            if let userInfo = responseInfo as [String:AnyObject]? {
                if let insideUserInfo = userInfo["user"] as? [String:AnyObject] {
                    if let accessToken = insideUserInfo["access_token"] as? String {
                        println("access token established, run completion")
                        self.token = accessToken
                        completion()
                    }
                }
            }
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
                if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let userId = insideUserIdInfo["id"] as? Int {
                        println("id established")
                        self.id = userId
                    }
                }
            }
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
                if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let username = insideUserIdInfo["username"] as? String {
                        println("username stored")
                        self.givenUser = username
                    }
                }
            }
            
        })
    }
    
    func createChildWithCompletion(completion: (childInfo: [String:AnyObject]) -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/children",
            "parameters" : [
                
                "first_name" : firstName,
                "last_name" : lastName,
                "dob" : dob,
                "address" : address,
                "phone_number" : phoneNumber,
                "height" : height,
                "weight" : weight
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("\(responseInfo)")
            
            if let childInfo = responseInfo as [String:AnyObject]? {
                if let parentInfo = childInfo["parent"] as? [String:AnyObject] {
                    if let userId = parentInfo["id"] as? Int {
                        println("id established")
                        if self.id == userId {
                            completion(childInfo: childInfo)
                        }
                    }
                }
                
            }
        })
    }
    
    func createChildMedicalInfoWithCompletin(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/child/\(stringId)/medical",
            "parameters" : [
                
                "conditions" : conditions,
                "medications" : medications,
                "notes" : notes,
                "allergies" : allergies,
                "insurance" : insurance,
                "religious_preference" : religiousPreference,
                "blood_type" : bloodType
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let medicalResponse = responseInfo as [String:AnyObject]? {
                if let childInfo = medicalResponse["child"] as? [String:AnyObject] {
                    if let userInfo = childInfo["parent"] as? [String:AnyObject] {
                        if let userId = userInfo["id"] as? Int {
                            if self.id == userId {
                                completion()
                            }
                        }
                    }
                }
            }
            
            
        })
    }
    
    func createChildContactWithCompletion(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/child/\(stringId)/contacts",
            "parameters" : [
                
                "first_name" : firstName,
                "last_name" : lastName,
                "relationship" : relationship,
                "address" : address,
                "phone_number" : phoneNumber,
                "alternate_number" : altNumber
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let contactResponse = responseInfo as [String:AnyObject]? {
                if stringId == contactResponse["contactable_id"] as? Int {
                    println("run completion")
                    completion()
                }
            }
        })
    }
    
    func createUserContactWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/contacts",
            "parameters" : [
                
                "first_name" : firstName,
                "last_name" : lastName,
                "relationship" : relationship,
                "address" : address,
                "phone_number" : phoneNumber,
                "alternate_number" : altNumber
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let contactResponse = responseInfo as [String:AnyObject]? {
                if self.id! == contactResponse["contactable_id"] as? Int {
                    println("run completion")
                    completion()
                }
            }
            
        })
    }
    
    func createCarpoolWithCompletion(completion: (carpoolInfo: [String:AnyObject]) -> Void) {
        
        var info = [
        
            "method" : "POST",
            "endpoint" : "/carpools",
            "parameters" : [
            
                "title" : title,
                "description" : descript
            ]
        ] as [String: AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let carpoolInfo = responseInfo as [String:AnyObject]? {
                if let name = carpoolInfo["title"] as? String {
                println("The name of the carpool is \(name)")
                    completion(carpoolInfo: carpoolInfo)
                }
            }
        })
    }
    
    func inviteUserWithCompletion(carpoolId: Int, completion: () -> Void) {
        
        var info = [
        
            "method" : "POST",
            "endpoint" : "/carpool/\(carpoolId)",
            "parameters" : [
            
                "email" : [email]
            ]
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            completion()
        })
    }

    
    
    ////////////////////////////////////////////////////////////////////////// GET
    
    
    func getUserInfoWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "GET",
            "endpoint" : "/user/\(givenUser!)"
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("\(responseInfo)")
            println("boom")
            
            if let userInfo = responseInfo as [String:AnyObject]? {
                if let insideUserInfo = userInfo["user"] as? [String:AnyObject] {
                    if let ul = insideUserInfo["username"] as? String {
                        println("This user is here")
                        self.usernameLabel = ul
                    }
                    if let fl = insideUserInfo["first_name"] as? String {
                        self.firstnameLabel = fl
                        println("Last name is here")
                    }
                    if let ll = insideUserInfo["last_name"] as? String {
                        self.lastnameLabel = ll
                    }
                    if let al = insideUserInfo["address"] as? String {
                        self.addressLabel = al
                    }
                    if let el = insideUserInfo["email"] as? String {
                        self.emailLabel = el
                    }
                    if let pl = insideUserInfo["phone_number"] as? String {
                        self.phoneLabel = pl
                   
                    }
             
                }
                
            }
            completion()
        })
    }
    
    func getChildrenIndexWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "GET",
            "endpoint" : "/user/\(givenUser!)/children"
            ] as [String:AnyObject]
        
        requestWithArrayInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("\(responseInfo)")
            
            if let childIndexInfo = responseInfo as [[String:AnyObject]]? {
                println("The array has been stored to childIds")
                self.childIds = childIndexInfo
                completion()
            }
            
            
        })
    }
    
    func getChildContactIndexWithCompletion(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
        
            "method" : "GET",
            "endpoint" : "/child/\(stringId)/contacts"
            ] as [String:AnyObject]
        
        requestWithArrayInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let contactsInfo = responseInfo as [[String:AnyObject]]? {
                println("The array has been stored to contactIds")
                self.contactIds = contactsInfo
                completion()
            }
            
        })
    }
    
    func getUserContactIndexWithCompletion(completion: () -> Void) {
        
        var info = [
        
            "method" : "GET",
            "endpoint" : "/user/\(givenUser!)/contacts"
        ] as [String:AnyObject]
        
        requestWithArrayInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let contactsInfo = responseInfo as [[String:AnyObject]]? {
                println("The array has been stored to contactIds")
                self.contactIds = contactsInfo
                completion()
            }
        })
    }
    
    func getCarpoolIndexWithCompletion(completion: () -> Void) {
        
        var info = [
        
            "method" : "GET",
            "endpoint" : "/user/\(givenUser!)/carpools"
        ] as [String:AnyObject]
        
        requestWithArrayInfo(info, andCompletion: { (responseInfo) -> Void in
            
            if let carpoolsInfo = responseInfo as [[String:AnyObject]]? {
                self.carpools = carpoolsInfo
                completion()
            }
        })
    }
    
    func getPendingInvitesWithCompletion(completion: () -> Void) {
        
        var info = [
        
            "method" : "GET",
            "endpoint" : "/user/\(givenUser!)/invites"
        ] as [String:AnyObject]
        
        requestWithArrayInfo(info, andCompletion: { (responseInfo) -> Void in
            
            if let invitesInfo = responseInfo as [[String:AnyObject]]? {
                self.invites = invitesInfo
                completion()
            }
        })
    }
    
    
    ///////////////////////////////////////////////////////////////////// PUT
    
    func updateUserWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "PUT",
            "endpoint" : "/user/\(ogUsername)",
            "parameters" : [
                
                "username" : username, // required
                "password" : password, // required
                "first_name" : firstName, // required
                "last_name" : lastName, // required
                "email" : email, // required
                "address" : address,
                "phone_number" : phoneNumber,
                "avatar" : avatar
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("\(responseInfo)")
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
                if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let username = insideUserIdInfo["username"] as? String {
                        println("username stored")
                        self.givenUser = username
                    }
              
                }
            }
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
                if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let userId = insideUserIdInfo["id"] as? Int {
                        println("id established")
                        if self.id == userId {
                            completion()
                        }
                    }
                }
            }
        })
    }
    
    func updateChildWithCompletion(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
            
            "method" : "PUT",
            "endpoint" : "/child/\(stringId)",
            "parameters" : [
                
                "first_name" : firstName,
                "last_name" : lastName,
                "dob" : dob,
                "address" : address,
                "phone_number" : phoneNumber,
                "height" : height,
                "weight" : weight
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println("\(responseInfo)")
            
            if let userIdInfo = responseInfo as [String:AnyObject]? {
          //      if let insideUserIdInfo = userIdInfo["user"] as? [String:AnyObject] {
                    if let parentId = userIdInfo["parent"] as? [String:AnyObject] {
                        if let userId = parentId["id"] as? Int {
                            println("id established")
                            if self.id == userId {
                                completion()
                            }
                        }
                    }
             //   }
            }
        })
    }
    
    func updateMedicalInfoWithCompletion(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
        
            "method" : "PUT",
            "endpoint" : "/child/\(stringId)/medical",
            "parameters" : [
            
                "conditions" : conditions,
                "medications" : medications,
                "notes" : notes,
                "allergies" : allergies,
                "insurance" : insurance,
                "religious_preference" : religiousPreference,
                "blood_type" : bloodType
            ]
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let updateInfo = responseInfo as [String:AnyObject]? {
                if let childInfo = updateInfo["child"] as? [String:AnyObject] {
                    if let parentInfo = childInfo["parent"] as? [String:AnyObject] {
                        if parentInfo["id"] as! Int == self.id! {
                            println("ran completion")
                            completion()
                        }
                    }
                }
            }
        })
    }
    
    func updateChildContactWithCompletion(contact: [String:AnyObject], completion: () -> Void) {
        
        var stringId = contact["id"] as! Int
        
        var info = [
        
            "method" : "PUT",
            "endpoint" : "/contact/\(stringId)",
            "parameters" : [
                
                "first_name" : firstName,
                "last_name" : lastName,
                "relationship" : relationship,
                "address" : address,
                "phone_number" : phoneNumber,
                "alternate_number" : altNumber
            ]
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            completion()
        })
    }
    
    func updateUserContactWithCompletion(contact: [String:AnyObject], completion: () -> Void) {
        
        var stringId = contact["id"] as! Int
        
        var info = [
            
            "method" : "PUT",
            "endpoint" : "/contact/\(stringId)",
            "parameters" : [
                
                "first_name" : firstName,
                "last_name" : lastName,
                "relationship" : relationship,
                "address" : address,
                "phone_number" : phoneNumber,
                "alternate_number" : altNumber
            ]
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            completion()
        })
        
    }
    
    func updateCarpoolWithCompletion(carpool: [String:AnyObject], completion: () -> Void) {
        
        var stringId = carpool["id"] as! Int
        
        var info = [
        
            "method" : "PUT",
            "endpoint" : "/carpool/\(stringId)",
            "parameters" : [
            
                "title" : title,
                "description" : descript
            ]
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            completion()
        })
    }
    
    func acceptInviteWithCompletion(carpoolId: Int, joinToken: String, completion: () -> Void) {
        
        var info = [
        
            "method" : "PUT",
            "endpoint" : "/carpool/\(carpoolId)/activate",
            "parameters" : [
            
                "join_token" : joinToken
            ]
        ] as [String:AnyObject]
        
        requestWithArrayInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
        })
        completion()
    }
    
    ///////////////////////////////////////////////////////////////////// DELETE
    
    func deleteChildWithCompletion(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
            
            "method" : "DELETE",
            "endpoint" : "/child/\(stringId)"
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            completion()
        })
        
    }
    
    func deleteMedicalInfoWithCompletion(child: [String:AnyObject], completion: () -> Void) {
        
        var stringId = child["id"] as! Int
        
        var info = [
            
            "method" : "DELETE",
            "endpoint" : "/child/\(stringId)/medical"
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            println("medical info deleted")
            completion()
        })
    }
    
    func deleteContactWithCompletion(contact: [String:AnyObject], completion: () -> Void) {
        
        var stringId = contact["id"] as! Int
        
        var info = [
        
            "method" : "DELETE",
            "endpoint" : "/contact/\(stringId)"
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            println("contact deleted")
            completion()
        })
    }
    
    func deleteCarpoolWithCompletion(carpool: [String:AnyObject], completion: () -> Void) {
        
        var stringId = carpool["id"] as! Int
        
        var info = [
        
            "method" : "DELETE",
            "endpoint" : "/carpool/\(stringId)"
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            println("carpool has been deleted")
            completion()
        })
    }
    
    func deleteUserFromCarpoolWithCompletion(carpoolId: Int, user: String, completion: () -> Void) {
        
        var info = [
        
            "method" : "DELETE",
            "endpoint" : "carpool/\(carpoolId)/user/\(user)"
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            println(responseInfo)
            completion()
        })
    }
    
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) -> Void)?) {
        
        let endpoint = info["endpoint"] as! String
        
        if let url = NSURL(string:  API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            if let token = token {
                
                request.setValue(token, forHTTPHeaderField: "Access-Token")
                
            }
            
            //// Body
            if request.HTTPMethod != "GET" {
                
                
                if let bodyInfo = info["parameters"] as? [String:AnyObject] {
                
                    let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
                    
                    let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
                    
                    let postLength = "\(jsonString!.length)"
                    
                    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                    
                    let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    request.HTTPBody = postData
                    
                }
            }
            //// Body
            
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                if data != nil {
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    completion?(responseInfo: json)
                    
                } else {
                    
                    completion?(responseInfo: nil)
                    
                    }
                }
            })
        }
    }
    
    func requestWithArrayInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [[String:AnyObject]]?) -> Void)?) {
    
        let endpoint = info["endpoint"] as! String
        
        
        println(API_URL + endpoint)
        
        if let url = NSURL(string:  API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            if let token = token {
                
                request.setValue(token, forHTTPHeaderField: "Access-Token")
                
            }
            
            //// Body
            
            if request.HTTPMethod != "GET" {
                
                if let bodyInfo = info["parameters"] as? [String:AnyObject] {
                
                    let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
                
                    let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
                
                    let postLength = "\(jsonString!.length)"
                
                    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                
                    let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                    request.HTTPBody = postData
                }
            }
            
            //// Body
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                println(data)
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [[String:AnyObject]] {
                    
                    completion?(responseInfo: json)
                } else {
                    
                    completion?(responseInfo: nil)
                    
                }

            })
        }
    }

}