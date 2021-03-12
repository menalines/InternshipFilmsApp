//
//  LoginViewController.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 5.03.21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private static var login = "user"
    private static var password = "pass"

    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signClicked(_ sender: Any) {
        if let login = loginField.text,
           let pass = passwordField.text,
           login == LoginViewController.login,
           pass == LoginViewController.password {
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
               let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
                sceneDelegate.window?.rootViewController = viewController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        } else {
            let ac = UIAlertController(title: "Authentication failed", message: "login = user,\npassword = pass", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    @IBAction func fieldChanged(_ sender: Any) {
        validate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func validate() {
        if loginField.text!.count >= 4 && passwordField.text!.count >= 4 {
            signInButton.isEnabled = true
        }
    }
}
