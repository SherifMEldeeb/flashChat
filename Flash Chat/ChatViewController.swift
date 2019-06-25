//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    var messegesArr: [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(gesture)
        

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        retrieveMesseges()
        messageTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardNotifications()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSubscribeKeyboardNotification()
    }
    
    
    
    

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell

        messageCell.messageBody.text = messegesArr[indexPath.row].messageBody
        messageCell.senderUsername.text = messegesArr[indexPath.row].sender
        messageCell.avatarImageView.image = UIImage(named: DesignIdentifiers.Images.egg.rawValue)
        
        if messageCell.senderUsername.text == Auth.auth().currentUser?.email{
            messageCell.messageBackground.backgroundColor = UIColor.flatMint()
        }else{
            messageCell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        
        return messageCell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messegesArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here: CANCELED
    
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendPressed(self)
        return false
    }

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
     
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messegesDB = Database.database().reference().child("messeges")
        
        let message = ["Sender": Auth.auth().currentUser?.email, "Message": messageTextfield.text]
        
        messegesDB.childByAutoId().setValue(message) { (error, refrence) in
            guard let err = error else {
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
                return
            }
            Alerts.Basic(with: "error", messege: err.localizedDescription, on: self)
        }
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMesseges(){
        let messegesDB = Database.database().reference().child("messeges")
        
        messegesDB.observe(.childAdded) { (snapshot) in
            let messSnap = snapshot.value as! Dictionary<String,String>
            
            let message: Message = Message(sender: messSnap["Sender"]!, Body: messSnap["Message"]!)
            
            self.messegesArr.append(message)
            
            self.messageTableView.reloadData()
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            Alerts.Basic(of: .networkIssue, on: self)
        }
        
    }
    


}
