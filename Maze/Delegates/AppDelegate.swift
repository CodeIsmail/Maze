//
//  AppDelegate.swift
//  Maze
//
//  Created by Ismail on 09/04/2021.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let dataController = DataController(modelName: "Exam")
    var firestoreDb: Firestore?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        dataController.load()
        FirebaseApp.configure()
        
        firestoreDb = Firestore.firestore()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
              // Show the app's signed-out state.
                //TODO NAVIGATE TO LOGIN SCREEN
                var loginVC = ControllerHelper.getLoginViewController()
                loginVC.dataController = self.dataController
                loginVC.firestoreDb = self.firestoreDb
                
                self.window?.rootViewController = loginVC
                
            } else {
              // Show the app's signed-in state.
                //TODO NAVIGATE TO HOME SCREEN
                let mainTabBarController = ControllerHelper.getTabBarRootViewController()
                
                mainTabBarController.firestoreDb = self.firestoreDb
                mainTabBarController.dataController = self.dataController
                
                self.window?.rootViewController = mainTabBarController
                
            }
          }

        return true
    }
    
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

