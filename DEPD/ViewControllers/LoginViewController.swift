//
//  LoginViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfUserName.makeItThemeTF()
        tfPassword.makeItThemeTF()
        
        buttonLogin.makeItThemePrimary()
        buttonRegister.makeItThemePrimary()
        
        tfUserName.isAccessibilityElement = true
        tfPassword.isAccessibilityElement = true
        buttonLogin.isAccessibilityElement = true
        buttonRegister.isAccessibilityElement = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserName.placeholder = "User Name".localized()
        tfPassword.placeholder = "Password".localized()
        
        tfUserName.accessibilityLabel = "User Name".localized()
        tfPassword.accessibilityLabel = "Password".localized()
        
        buttonLogin.accessibilityLabel = "press login and go to next screen".localized()
        buttonRegister.accessibilityLabel = "Register".localized()
        
        buttonLogin.setTitle("login".localized(), for: .normal)
        buttonRegister.setTitle("Register".localized(), for: .normal)
        

        buttonLogin.addTapGestureRecognizer {
            Bootstrapper.createHome()
        }
        buttonRegister.addTapGestureRecognizer {}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
