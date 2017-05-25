//
//  TaskWhenReachable+CoreDataProperties.swift
//  SaveEventually
//
//  Created by Elliot Leibu on 25/5/17.
//  Copyright © 2017 elliotleibu. All rights reserved.
//

import Foundation
import CoreData


extension TaskWhenReachable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskWhenReachable> {
        return NSFetchRequest<TaskWhenReachable>(entityName: "TaskWhenReachable")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var task: NSObject?

}
