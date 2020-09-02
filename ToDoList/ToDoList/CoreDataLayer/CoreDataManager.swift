//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core data manager object

// Object to manage core data entities
final class CoreDataManager {
    
    // MARK: - Properties
    
    private var coreDataStack: CoreDataStack
    // All task entities stored in core data
    var taskList: [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        guard let result = try? coreDataStack.mainContext.fetch(request) else { return [] }
        return result
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Methods
    
    // Create task and store it in core data
    func createTask(named name: String) -> Bool{
        let task = Task(context: coreDataStack.mainContext)
        task.name = name
        return coreDataStack.saveContext()
    }
    
    // Delete all task entities in core data
    func reset() -> Bool {
        taskList.forEach { self.coreDataStack.mainContext.delete($0) }
        return coreDataStack.saveContext()
    }
}
