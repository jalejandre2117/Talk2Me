//
//  LoginViewController.swift
//  Talk2Me
//
//  Created by Jorge Alejandre on 12/9/18.
//  Copyright © 2018 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
 
    @IBAction func onSignUp(_ sender: Any) {
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            let alertController = UIAlertController(title:"Fill in Missing Fields", message: "Please enter a username and a password.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alertController.addAction(OKAction)
            present(alertController, animated: true)
        } else {
            let newUser = PFUser()
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    let alertController = UIAlertController(title:"Error Found", message: error.localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true)
                } else {
                    print("Yay, created a user!")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)

            }
        }
    }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            let alertController = UIAlertController(title:"Fill in Missing Fields", message: "Please enter a username and a password.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true)
            
        } else {
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
                    if let error = error {
                        let alertController = UIAlertController(title:"Error Encountered", message: error.localizedDescription, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true)
                    
                    } else {
                        print("You're logged in!")
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        // display view controller that needs to shown after successful login
}
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                if error?._code == 202 {
                    print("Username is Already Taken")
                    // display view controller that needs to shown after successful login
            }
        }
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
