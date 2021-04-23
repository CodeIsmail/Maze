//
//  RootViewController.swift
//  Maze
//
//  Created by Ismail on 14/04/2021.
//

import UIKit
import Firebase

class RootViewController: UITabBarController, UITabBarControllerDelegate {

    var firestoreDb: Firestore!
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        defaultConfiguration(self.viewControllers![0] as! UINavigationController)
    }

    fileprivate func defaultConfiguration(_ selectedNavigationController: UINavigationController) {
        if let selectExamViewController = selectedNavigationController.topViewController as? SelectExamViewController{
            selectExamViewController.dataController = dataController
            selectExamViewController.firestoreDb = firestoreDb
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedNavigationController = viewController as? UINavigationController{
            if let historyViewController = selectedNavigationController.topViewController as? HistoryViewController{
                historyViewController.firestoreDb = firestoreDb
            }
            
            defaultConfiguration(selectedNavigationController)
        }
    }
}
