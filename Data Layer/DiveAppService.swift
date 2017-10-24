//
//  DiveAppService.swift
//  DiveAppFirebase
//
//  Created by Trym Lintzen on 24-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore


class DiveAppService {
    
    public static let sharedInstance = DiveAppService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    var ref: DatabaseReference!
    
    public func getDiveAppData() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value , with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let diveAppItem = data["data"] as? NSArray {
                var itemArray:[DiveAppProperties] = []
                for item in diveAppItem {
                    if let itemObj = self.getValue(itemDict: item as! NSDictionary) {
                        itemArray.append(itemObj)
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationIDs.allItemsID),
                                                object: self,
                                                userInfo: [dictKey.divingAppData : itemArray])
            }
        })
    
    }
 
    func getValue(itemDict: NSDictionary) -> DiveAppProperties? {
        let decoder = JSONDecoder()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: itemDict, options: .prettyPrinted)
            let item = try decoder.decode(DiveAppProperties.self, from: jsonData)
            return item
        } catch {
            return nil
        }
    }
  
    
}
