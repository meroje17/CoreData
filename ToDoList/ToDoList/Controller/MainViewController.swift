//
//  MainViewController.swift
//  ToDoList
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

// MARK: - Main user interface

final class MainViewController: UIViewController {

    // MARK: - Property
    
    // Manage all task entities
    private var coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "ToDoList"))
    
    // MARK: - Outlet
    
    // Table view which contains all tasks name
    @IBOutlet private weak var taskTableView: UITableView!
        
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Actions
    
    // When user tap reset button
    @IBAction func tapResetButton(_ sender: UIBarButtonItem) {
        reset()
    }
    
    // When user tap add button
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        addNewTask()
    }
    
    
    // MARK: - Private functions
    
    // Assign data source and delegate for table view
    private func initUI() {
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    // All action to create new task
    private func addNewTask() {
        
        // Alert controller init
        let alert = UIAlertController(title: "New task", message: "Write the name of new task.", preferredStyle: .alert)
        
        // Adding text field for user write name of new task
        alert.addTextField { (textField) in
            textField.placeholder = "Name of task"
        }
        
        // Cancel action added
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add action added with background handler when user tap on
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            
            // Verification textField not empty
            guard let name = alert.textFields?[0].text, name != "" else {
                self.error(ofType: .fieldEmpty)
                return
            }
            
            // Core data manager create and saved task
            if !self.coreDataManager.createTask(named: name) {
                DispatchQueue.main.async {
                    // Display error if context saving not worked
                    self.error(ofType: .save)
                }
            } else {
                DispatchQueue.main.async {
                    // Update table view with new task
                    self.taskTableView.reloadData()
                }
            }
        }))
        
        // Present alert with all actions and text field
        present(alert, animated: true)
    }
    
    // Reset all entities
    private func reset() {
        if !coreDataManager.reset() {
            DispatchQueue.main.async {
                // Display error if context saving not worked
                self.error(ofType: .save)
            }
        } else {
            DispatchQueue.main.async {
                // Update table view with empty taskList
                self.taskTableView.reloadData()
            }
        }
    }
}

// MARK: - Extension for UITableView

// Initialization of user interface table view
extension MainViewController: UITableViewDataSource {
    
    // Init number of row of table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.taskList.count
    }
    
    // Creation of cells for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let name = coreDataManager.taskList[indexPath.row].name else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel!.text = name
        return cell
    }
}

// Manage footer of table view
extension MainViewController: UITableViewDelegate {
    
    // Create UIView (label) for footer of table view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some tasks"
        label.font = UIFont(name: "Avenir", size: 18)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }
    
    // Manage footer : if taskList is empty hide it, else display it
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if coreDataManager.taskList.count == 0 {
            return 200
        } else {
            return 0
        }
    }
}
