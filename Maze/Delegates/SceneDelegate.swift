//
//  SceneDelegate.swift
//  Maze
//
//  Created by Ismail on 09/04/2021.
//

import UIKit
import Firebase
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    let dataController = DataController(modelName: "Exam")
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        dataController.load()
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        // if user is logged in before
        if UserDefaultManager.shared.getUser() != nil {
            let mainTabBarController = ControllerHelper.getTabBarRootViewController()
            
            window?.rootViewController = mainTabBarController
            mainTabBarController.firestoreDb = Firestore.firestore()
            mainTabBarController.dataController = dataController
        } else {
            window?.rootViewController = ControllerHelper.getLoginViewController()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("Failed to sign in : \(error) ")
            return
        }
        
        UserDefaultManager.shared.saveUser(user.userID)
        
        let mainTabBarController = ControllerHelper.getTabBarRootViewController()
        mainTabBarController.firestoreDb = Firestore.firestore()
        mainTabBarController.dataController = dataController
        
        changeRootViewController(mainTabBarController)
        
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        GIDSignIn.sharedInstance().handle(URLContexts.first?.url)
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        
        // add animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }
}

