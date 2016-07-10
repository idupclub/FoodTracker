//
//  FoodItem.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/10.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

class FoodItem: NSObject,  NSCoding {
    
    var foodName: String
    
    var foodPhoto: UIImage?
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("foods")
    
    
    init?(name: String, photo: UIImage?) {
        
        self.foodName = name
        self.foodPhoto = photo
        
        super.init()
        
        if name.isEmpty  {
            return nil
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        self.init(name: name, photo: photo)
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(foodName, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(foodPhoto, forKey: PropertyKey.photoKey)
    }
    
}

struct PropertyKey {
    static let nameKey = "name"
    static let photoKey = "photo"
}
