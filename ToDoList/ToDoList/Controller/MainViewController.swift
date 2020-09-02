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
    
    private var coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "ToDoList"))
    
    // MARK: - Outlet
    
    @IBOutlet private weak var taskTableView: UITableView!
        
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Actions
    
    @IBAction func tapResetButton(_ sender: UIBarButtonItem) {
        reset()
    }
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        addNewTask()
    }
    
    
    // MARK: - Private functions
    
    private func initUI() {
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    private func addNewTask() {
        let alert = UIAlertController(title: "New task", message: "Write the name of new task.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name of task"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let name = alert.textFields?[0].text, name != "" else {
                self.error(ofType: .fieldEmpty)
                return
            }
            
            if !self.coreDataManager.createTask(named: name) {
                DispatchQueue.main.async {
                    self.error(ofType: .save)
                }
            } else {
                DispatchQueue.main.async {
                    self.taskTableView.reloadData()
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    private func reset() {
        if !coreDataManager.reset() {
            DispatchQueue.main.async {
                self.error(ofType: .save)
            }
        } else {
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let name = coreDataManager.taskList[indexPath.row].name else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel!.text = name
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some tasks"
        label.font = UIFont(name: "Avenir", size: 18)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if coreDataManager.taskList.count == 0 {
            return 200
        } else {
            return 0
        }
    }
}
