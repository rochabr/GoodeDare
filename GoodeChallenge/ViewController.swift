//
//  ViewController.swift
//  GoodeChallenge
//
//  Created by Fernando Rocha Silva on 9/11/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit
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
            case .Success( _, _, let accessToken):
                print("Logged in!")
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken.authenticationToken)
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                    print("\(user!.displayName)")
                    self.fetchFriends()
                }
        }
    }
    
    func fetchFriends(){
        let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        let request = FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params)
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if error != nil {
                let errorMessage = error.localizedDescription
            }
            else {//if result.isKindOfClass(NSDictionary){
                /* Handle response */
                print("Friends: \(result)")
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: LoginButton) {
        print("User Logged Out")
        try! FIRAuth.auth()!.signOut()
    }

}

