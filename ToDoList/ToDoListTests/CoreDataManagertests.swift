//
//  CoreDataManagertests.swift
//  ToDoListTests
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

@testable import ToDoList
import XCTest

final class CoreDataManagertests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests cycle life
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = MockCoreDataStack(modelName: "ToDoList")
        // Here we can use mock core data stack because it's inherite about core data stack class
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
        coreDataManager = nil
    }
    
    // MARK: - Tests
    
    func testCreateTaskMethod_WhenSaveWork_ShouldHaveTaskListCountEqualOne() {
        if coreDataManager.createTask(named: "TestTask") {
            XCTAssertTrue(coreDataManager.taskList.count == 1)
            XCTAssertTrue(coreDataManager.taskList[0].name! == "TestTask")
        } else {
            XCTFail()
        }
    }
    
    func testResetMethod_WhenSaveWork_ShouldHaveEmptyTaskList() {
        if coreDataManager.createTask(named: "Test2Task") {
            if coreDataManager.reset() {
                XCTAssertTrue(coreDataManager.taskList.isEmpty)
            } else {
                XCTFail()
            }
        }
    }
}
