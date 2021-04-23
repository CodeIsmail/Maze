//
//  ControllerHelper.swift
//  Maze
//
//  Created by Ismail on 23/04/2021.
//

import Foundation
import UIKit

class ControllerHelper{
    
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func getLoginViewController() -> LoginViewController{
        return storyboard.instantiateViewController(identifier: "LoginVC") as! LoginViewController
    }
    
    static func getExamPageViewController()-> ExamPageViewController{
        return storyboard.instantiateViewController(withIdentifier: "ExamPage") as! ExamPageViewController
    }
    
    static func getTabBarRootViewController()-> RootViewController{
        return storyboard.instantiateViewController(identifier: "TabVC") as! RootViewController
    }
}
