//
//  ViewController+UIAlert.swift
//  Maze
//
//  Created by Ismail on 23/04/2021.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showErrorAlert(message: String){
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true)
    }
    
    func showInfoAlert(message: String, completion: (()-> Void)?){
        let alertView = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
            completion?()
        }))
        alertView.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alertView, animated: true)
    }
    
    func showInfoOkOnlyAlert(message: String){
        let alertView = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true)
    }
}
