//
//  ChatView.swift
//  Flash Chat
//
//  Created by Sherif M. Eldeeb on 1/30/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func subscribeKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector( adjustKeyboard(_:) ), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector( adjustKeyboard(_:) ), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unSubscribeKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustKeyboard(_ notification: NSNotification){
        if notification.name == UIResponder.keyboardWillShowNotification{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }else if notification.name == UIResponder.keyboardWillHideNotification {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
        
    }
    
    private func getKeyboardHeight(_ notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
}
