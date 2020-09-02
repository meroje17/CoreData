//
//  Error.swift
//  ToDoList
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

extension UIViewController {
    func saveError() {
        let alert = UIAlertController(title: "Error", message: "Save failed. Please retry later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
