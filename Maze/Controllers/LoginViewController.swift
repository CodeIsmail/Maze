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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
}
