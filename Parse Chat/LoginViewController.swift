//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Olga Andreeva on 6/26/17.
//  Copyright © 2017 Olga Andreeva. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickSignUp(_ sender: Any) {
        if hasRequiredParam() {
            let newUser = PFUser()
            
            // set user properties
            newUser.username = usernameLabel.text
            newUser.password = passwordLabel.text
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    func hasRequiredParam() -> Bool {
        if (usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Missing Username or Password", message: "Please enter a username or password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
            alertController.addAction(OKAction)
            present(alertController, animated: true) {}
            return false
        }
        return true
    }
    
    @IBAction func didClickLogin(_ sender: Any) {
        if hasRequiredParam() {
            let username = usernameLabel.text ?? ""
            let password = passwordLabel.text ?? ""

            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
            }
        }
    }
    
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
        */
}
