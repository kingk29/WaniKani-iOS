//
//  WaniApiManager.swift
//  
//
//  Created by Andriy K. on 8/11/15.
//
//

import Alamofire
import RealmSwift


// Define your models like regular Swift classes
class Dog: Object {
  dynamic var name = ""
  dynamic var age = 0
}
class Person: Object {
  dynamic var name = ""
  dynamic var picture = NSData()
  let dogs = List<Dog>()
}

public class WaniApiManager: NSObject {
  
  public static let sharedInstance = WaniApiManager()
  
  private static let baseURL = "https://www.wanikani.com/api/"
  private static let myKey = "c6ce4072cf1bd37b407f2c86d69137e3"
  
  private static let userInfoKey = "user_information"
  private static let requestedInfo = "requested_information"
  
  public func fetchUserInfo(userBlock:(User?)->()) {
    Alamofire.request(.GET, "https://www.wanikani.com/api/user/c6ce4072cf1bd37b407f2c86d69137e3/study-queue", parameters: nil)
      .responseJSON(options: NSJSONReadingOptions.AllowFragments) { (_, _, JSON, _) -> Void in
        var user: User? = nil
        if let dict = JSON as? NSDictionary {
          if let userInfo = dict[WaniApiManager.userInfoKey] as? NSDictionary {
            user = User.userFromDictionary(userInfo)
          }
        }
        userBlock(user)
    }
  }
  
}
