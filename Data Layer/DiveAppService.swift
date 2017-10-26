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
import SVProgressHUD

class DiveAppService {
    
    public static let sharedInstance = DiveAppService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    var ref: DatabaseReference!
    
    public func getDiveAppData() {
        ref = Database.database().reference()
        
        ref.observeSingleEvent(of: .value , with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let diveAppItem = data["data"] as? [String : Any] {
                var itemArray:[DiveAppProperties] = []
                for (key, item) in diveAppItem {
                    if var itemObj = self.getValue(itemDict: item as! NSDictionary) {
                        itemObj.id = key
                        itemArray.append(itemObj)
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationIDs.allItemsID),
                                                object: self,
                                                userInfo: [dictKey.divingAppData : itemArray])
            }
        })
        
        ref.child("data").observe(.childAdded, with: { (snapshot) in
            if let dataItem = snapshot.value as? NSDictionary,
                var itemObject = self.getValue(itemDict: dataItem) {
                itemObject.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationIDs.addItemsID),
                                                object: self,
                                                userInfo: [dictKey.divingAppData : itemObject])
            }
        })
        
        ref.child("data").observe(.childChanged) { (snapshot) in
            if let dataItem = snapshot.value as? NSDictionary,
                var itemObject = self.getValue(itemDict: dataItem) {
                itemObject.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationIDs.changeItemsID),
                                                object: self,
                                                userInfo: [dictKey.divingAppData : itemObject])
                
            }
        }
    }
        
        public func getValue(itemDict: NSDictionary) -> DiveAppProperties? {
            let decoder = JSONDecoder()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: itemDict, options: .prettyPrinted)
                let item = try decoder.decode(DiveAppProperties.self, from: jsonData)
                return item
            } catch {
                return nil
            }
        }
        
        public func dictionaryRepresentation(diveItem: DiveAppProperties) -> [String : Any]? {
            let encoder = JSONEncoder()
            if #available(iOS 11.0, *) {
                encoder.outputFormatting = .sortedKeys
            }
            do {
                let encodedDiveItem = try encoder.encode(diveItem)
                let dict = try JSONSerialization.jsonObject(with: encodedDiveItem, options: []) as? [String: Any]
                return dict as [String : Any]?
            } catch {
                return [:]
            }
        }
        
        func addDiveItem(diveItem: DiveAppProperties) {
            let AddDict = dictionaryRepresentation(diveItem: diveItem)
            ref.child("data").child(diveItem.id).setValue(AddDict)
        }
        
        func changeDiveItem(diveItem: DiveAppProperties) {
            let changeItem = dictionaryRepresentation(diveItem: diveItem)
            ref.child("data").child(diveItem.id).updateChildValues(changeItem!)
        }
        
        func deleteDiveItem(diveItem: DiveAppProperties) {
            ref.child("data").child(diveItem.id).removeValue()
        }
        
}
