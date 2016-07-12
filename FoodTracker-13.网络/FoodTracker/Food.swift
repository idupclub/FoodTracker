//
//  FoodItem.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/10.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

class Food: NSObject,  NSCoding {
    
    var name: String
    
    var photo: UIImage?
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("foods")
    
    
    init?(name: String, photo: UIImage?) {
        
        self.name = name
        self.photo = photo
        
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
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
    }
    
}

struct PropertyKey {
    static let nameKey = "name"
    static let photoKey = "photo"
}
