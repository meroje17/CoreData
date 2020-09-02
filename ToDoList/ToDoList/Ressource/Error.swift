//
//  Error.swift
//  ToDoList
//
//  Created by Jérôme Guèrin on 02/09/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

enum Error: String {
    case save = "Save failed. Please retry later."
    case fieldEmpty = "There are empty field, please fill it."
}
extension UIViewController {
    func error(ofType type: Error) {
        let alert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
