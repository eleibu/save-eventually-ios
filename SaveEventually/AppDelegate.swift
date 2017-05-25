//
//  AppDelegate.swift
//  SaveEventually
//
//  Created by Elliot Leibu on 25/5/17.
//  Copyright © 2017 elliotleibu. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.reachability.whenReachable = { reachability in
            self.tryExecuteTasks()
        }
        do {
            try self.reachability.startNotifier()
        } catch let error as NSError {
            // TODO: handle error
        }
        
        return true
    }
    
    func scheduleTask(_ task: WhenReachable) {
        self.addTaskToCoreData(task)
        
        if self.reachability.isReachable {
            self.tryExecuteTasks()
        }
    }
    
    func tryExecuteTasks() {
        if let nextTask = self.getNextTaskAndDeleteFromCoreData() {
            if self.reachability.isReachable {
                nextTask.execute(
                    { self.tryExecuteTasks() },
                    connectionErrorCompletionHandler: { self.addTaskToCoreData(nextTask) },
                    otherErrorCompletionHandler: { self.tryExecuteTasks() }
                )
            } else {
                self.addTaskToCoreData(nextTask)
            }
        }
    }
    
    func addTaskToCoreData(_ task: WhenReachable) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let taskWhenReachableDescription = NSEntityDescription.entity(forEntityName: "TaskWhenReachable", in: managedContext)
        let taskWhenReachable = NSManagedObject(entity: taskWhenReachableDescription!, insertInto: managedContext) as! TaskWhenReachable
        taskWhenReachable.task = task
        taskWhenReachable.date = Date() as NSDate
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            // TODO: handle error
        }
    }
    
    func getNextTaskAndDeleteFromCoreData() -> WhenReachable? {
        var returnTask: WhenReachable?
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskWhenReachable>(entityName: "TaskWhenReachable")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        var managedObjects : [NSManagedObject]?
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            managedObjects = results as [NSManagedObject]
        } catch let error as NSError {
            // TODO: handle error
        }
        
        if let managedObjects = managedObjects {
            for i in 0 ..< managedObjects.count {
                if let firstTaskWhenReachable = managedObjects[i] as? TaskWhenReachable {
                    if let firstWhenReachable = firstTaskWhenReachable.task as? WhenReachable {
                        returnTask = firstWhenReachable
                        
                        managedContext.delete(firstTaskWhenReachable)
                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            // TODO: handle error
                        }
                        
                        break
                    }
                }
            }
        }
        
        return returnTask
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SaveEventually")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
