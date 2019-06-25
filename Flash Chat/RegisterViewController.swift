//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import FirebaseAuth
import SVProgressHUD


class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

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
        if let mail = emailTextfield.text{
            Auth.auth().createUser(withEmail: mail, password: passwordTextfield.text!) { (user, Error) in
                
                if let err = Error{
                    Alerts.Basic(with: "Error", messege: err.localizedDescription, on: self)
                }else{
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: DesignIdentifiers.segues.goToChat.rawValue, sender: self)
                }
            }
        }else{
            Alerts.Basic(of: .InvalidEmail, on: self)
        }
   }
    
    
}
