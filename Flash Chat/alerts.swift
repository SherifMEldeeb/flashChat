//
//  alerts.swift
//  Flash Chat
//
//  Created by Sherif M. Eldeeb on 1/24/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct Alerts{
    private init(){}
    
    enum AlertTypes {
        case welcome
        case InvalidEmail
        case networkIssue
        case InvalidPassword
    }
    
    private static func BasicAlert(on vc: UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func Basic(of type:AlertTypes, on vc: UIViewController ){
        switch type {
        case .welcome:
            BasicAlert(on: vc, with: "Welcome..", message: "Thank You For being awesome with us ^_^")
        case .InvalidEmail:
            BasicAlert(on: vc, with: "Invalid Email", message: "Please use a valid Email To Register")
        case .networkIssue:
            BasicAlert(on: vc, with: "Oops!!", message: "Sorry but there is something wrong please check your internet connection and tryAgain...")
        case .InvalidPassword:
            BasicAlert(on: vc, with: "Invalid Password", message: "Please make sure that your password is not Empty Or less 6 characters")
        }
    }
    static func Basic(with Title: String,messege: String ,on vc: UIViewController ){
        BasicAlert(on: vc, with: Title, message: messege)
    }
}

