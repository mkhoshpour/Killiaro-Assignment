//
//  UIViewController + Alert.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 2/2/22.
//

import UIKit


extension UIViewController {
    func showAlertWith(_ message: String, title: String, completion: Completion) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(ac, animated: true, completion: nil)
    }
}
