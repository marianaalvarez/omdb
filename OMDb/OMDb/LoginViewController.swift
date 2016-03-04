//
//  LoginViewController.swift
//  OMDb
//
//  Created by Mariana Alvarez on 04/03/16.
//  Copyright © 2016 Mariana Alvarez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cpf.delegate = self
        self.password.delegate = self
        
        self.cpf.layer.borderColor = UIColor(red:0.829, green:0.124, blue:0.001, alpha:1).CGColor
        self.cpf.layer.borderWidth = 1
        self.cpf.layer.cornerRadius = 5
        
        self.password.layer.borderColor = UIColor(red:0.829, green:0.124, blue:0.001, alpha:1).CGColor
        self.password.layer.borderWidth = 1
        self.password.layer.cornerRadius = 5
        
        self.loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.alpha = 0.5
        self.loginButton.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.cpf.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if !self.cpf.text!.isEmpty && !self.password.text!.isEmpty {
            self.loginButton.alpha = 1
            self.loginButton.userInteractionEnabled = true
        } else {
            self.loginButton.alpha = 0.5
            self.loginButton.userInteractionEnabled = false
        }
        
        return true
    }
    

}
