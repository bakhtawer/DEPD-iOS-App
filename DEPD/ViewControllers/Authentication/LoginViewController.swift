//
//  LoginViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

class LoginViewController: BaseViewController {
    
    let service = APIService()
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    @IBOutlet weak var labelForgotPassword: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfUserName.makeItThemeTF()
        tfPassword.makeItThemeTF()
        
        buttonLogin.makeItThemePrimary()
        buttonRegister.makeItThemePrimary()
        
        labelForgotPassword.makeItTheme(.regular, 12, .appBlue, 14.06)
        
        tfUserName.isAccessibilityElement = true
        tfPassword.isAccessibilityElement = true
        buttonLogin.isAccessibilityElement = true
        buttonRegister.isAccessibilityElement = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserName.placeholder = "login_user_name".localized()
        tfPassword.placeholder = "login_password".localized()
        
        tfUserName.accessibilityLabel = "login_user_name".localized()
        tfPassword.accessibilityLabel = "login_password".localized()
        
        buttonLogin.accessibilityLabel = "press login and go to next screen".localized()
        buttonRegister.accessibilityLabel = "login_register".localized()
        
        labelForgotPassword.text = "login_forgot_password".localized()
        
        buttonLogin.setTitle("login_login".localized(), for: .normal)
        buttonRegister.setTitle("login_register".localized(), for: .normal)
        

        buttonLogin.addTapGestureRecognizer {
            Bootstrapper.createHome()
        }
        
        buttonRegister.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionOne.self)
            openModuleOnNavigation(from: self, controller: view)
        }
        
        labelForgotPassword.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: ForgotPasswordViewController.self)
            view.previousEmail = self?.tfUserName.text ?? ""
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        setNavBarColor(.appBG)
    }
    
}
