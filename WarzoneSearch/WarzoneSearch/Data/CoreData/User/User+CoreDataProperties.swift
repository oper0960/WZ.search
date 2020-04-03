//
//  User+CoreDataProperties.swift
//  
//
//  Created by Gilwan Ryu on 2020/03/17.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String
    @NSManaged public var platform: String
    @NSManaged public var updateTime: Date
}
