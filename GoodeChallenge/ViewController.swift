//
//  ViewController.swift
//  GoodeChallenge
//
//  Created by Fernando Rocha Silva on 9/11/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase

class ViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = LoginButton(readPermissions: [ .PublicProfile, .Email, .UserFriends ])
        
        loginButton.delegate = self
        loginButton.center = self.view.center;
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidCompleteLogin(loginButton: LoginButton, result: LoginResult) {
        switch result {
            case .Failed(let error):
                print(error)
            case .Cancelled:
                print("User cancelled login.")
            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
        }
    }
    
    func loginButtonDidLogOut(loginButton: LoginButton) {
        print("User Logged Out")
    }

}

