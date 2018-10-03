//
//  LoginVC.swift
//  ChatApp
//
//  Created by Arsal Jamal on 03/10/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LoginVC: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (AuthDataResult, Error) in
            if Error != nil {
                print("error logging in \(Error!)")
            }
            else{
                print("sucess")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "chat", sender: self)
            }
        }
        
        
    }
    

}
