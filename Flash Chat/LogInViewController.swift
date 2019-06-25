//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase
import SVProgressHUD



class LogInViewController: UIViewController {

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
        if let mail = emailTextfield.text{
            if let pass = passwordTextfield.text{
                
                Auth.auth().signIn(withEmail: mail, password: pass) { (messege, error) in
                    if let err = error{
                        Alerts.Basic(with: "Error", messege: err.localizedDescription, on: self)
                    }else{
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: DesignIdentifiers.segues.goToChat.rawValue, sender: self)
                        Alerts.Basic(with: "Yaaay", messege: "Welcome Back...🥳", on: self)
                    }
                
                }

            }else{  Alerts.Basic(of: .InvalidPassword, on: self)          }
            
        }else{ Alerts.Basic(of: .InvalidEmail, on: self) }
    }
    


    
}  
