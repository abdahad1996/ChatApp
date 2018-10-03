//
//  RegisterVC.swift
//  ChatApp
//
//  Created by Arsal Jamal on 03/10/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterVC: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        //TODO: Set up a new user on our Firbase database
        
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print("error\(error!)")
                SVProgressHUD.dismiss()
            }
            else{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "chat", sender: self)
            }
        }
        
        
    } 
   }
