//
//  CoreDataStack.swift
//  ToDoList
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core data stack object

// Contain : container with model, context, coordinator
open class CoreDataStack {
    
    // MARK: - Properties
    
    // Name of xcdatamodel
    let modelName: String
    
    // Reference of core data container, to have access of core data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistend  stores : \(error)")
            }
        }
        return container
    }()
    
    // The context, tracks changes to instances of your app’s types
    lazy var mainContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // MARK: - Initializer
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Method
    
    func saveContext() -> Bool {
        guard mainContext.hasChanges else { return false }
        do {
            try mainContext.save()
            return true
        } catch {
            return false
        }
    }
}
