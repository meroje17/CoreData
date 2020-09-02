//
//  MockCoreDataStack.swift
//  ToDoListTests
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import ToDoList
import Foundation
import CoreData

// MARK: - Mock core data stack object

// Object to use in test
final class MockCoreDataStack: CoreDataStack {

    // MARK: - Initializer
    
    // Loading persistent container in mock core data stack
    override init(modelName: String) {
        super.init(modelName: modelName)
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistend  stores : \(error)")
            }
        }
        self.persistentContainer = container
    }
}
