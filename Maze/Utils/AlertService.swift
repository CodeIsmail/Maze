//
//  AlertService.swift
//  Maze
//
//  Created by Ismail on 21/04/2021.
//

import UIKit

class AlertService{
    
    func alert(score: String, hasPassed: Bool, completion: @escaping (_ viewId: Int)->Void) -> AlertUIViewController {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertUIViewController
        viewController.hasPassed =  hasPassed
        viewController.score = score
        viewController.buttonAction = completion
        return viewController
    }
}
