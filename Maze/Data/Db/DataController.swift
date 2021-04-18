//
//  DataCController.swift
//  Maze
//
//  Created by Ismail on 12/04/2021.
//

import Foundation
import CoreData

class DataController{
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
//    let backgroundContext: NSManagedObjectContext!
//    
//    func configureContexts() {
//        viewContext.automaticallyMergesChangesFromParent =  true
//        backgroundContext.automaticallyMergesChangesFromParent = true
//        
//        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
//        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
//    }
    
    init(modelName: String){
        persistentContainer = NSPersistentContainer(name: modelName)
//        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func load(completion: (()-> Void)? = nil) {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            //self.saveIfNeeded()
            //self.configureContexts()
            completion?()
        }
    }
}

extension DataController{
    
    func saveIfNeeded() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
}
