//
//  LoginViewController.swift
//  Maze
//
//  Created by Ismail on 11/04/2021.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var loginWithGoogleButton: GIDSignInButton!
    let signInConfig = GIDConfiguration(clientID: GOOGLE_CLIENT_ID)
    var dataController: DataController!
    var firestoreDb: Firestore!
    private let delegate = UIApplication.shared.delegate as! AppDelegate

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
            
        loginWithGoogleButton.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func signIn(_ sender: Any) {
      GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }

        // If sign in succeeded, display the app's main content View.
          
          UserDefaultManager.shared.saveUser(user?.userID)
          
          let mainTabBarController = ControllerHelper.getTabBarRootViewController()
          mainTabBarController.firestoreDb = self.delegate.firestoreDb
          mainTabBarController.dataController = self.delegate.dataController
          
          ControllerHelper.changeRootViewController(mainTabBarController, window: self.window)
      }
    }

}
