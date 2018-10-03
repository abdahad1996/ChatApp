//
//  ViewController.swift
//  ChatApp
//
//  Created by Arsal Jamal on 03/10/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    var messageArray = [Message]()
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate=self
        messageTableView.dataSource=self
        
        
        
        //TODO: Set yourself as the delegate of the text field here:
        
        messageTextfield.delegate = self
        
        //TODO: Set the tapGesture here:
        
        let tapGesture = UITapGestureRecognizer(target: self, action:
            #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        //TODO: Register your MessageCell.xib file here:
        
        messageTableView.register(UINib.init(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessages()
        messageTableView.separatorStyle = .none
        
        
    }
    
    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text=messageArray[indexPath.row].messageBody
        cell.senderUsername.text!=messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String! {
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        }
        else{
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        return cell 
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    //TODO: Declare tableViewTapped here:
    func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
    
    
    
    //TODO: Declare configureTableView here:
    
    func configureTableView(){
        messageTableView.rowHeight=UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight=120
    }
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    
    
    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        UIView.animate(withDuration: 1) { 
            self.heightConstraint.constant=308
            self.view.layoutIfNeeded()        }
    }
    
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant=50
            self.view.layoutIfNeeded()
    }
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled=false
        sendButton.isEnabled = false
        let msgdb = Database.database().reference().child("Messages")
        let msgDict = ["Sender":Auth.auth().currentUser?.email,"MessageBody" : messageTextfield.text!                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ]
        msgdb.childByAutoId().setValue(msgDict) { (error, reference) in
            if error != nil {
                print("error writing to database \(error!)")
            }
            else{
                print("successfully written to database")
                self.messageTextfield.isEnabled=true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
            
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    func retrieveMessages(){
        let msgdb = Database.database().reference().child("Messages")
        msgdb.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let messageObj = Message()
            if let text = snapshotValue["MessageBody"]{
                messageObj.messageBody=text
                
                if let sender = snapshotValue["Sender"]{
                    messageObj.sender=sender
                    self.messageArray.append(messageObj)
                }

            }
            self.configureTableView()
            self.messageTableView.reloadData()
        })
            
        
        
    }
    
    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do{
        try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true )
        }
        catch {
            print("error logging out \(error)")
        }
    }
    


}

