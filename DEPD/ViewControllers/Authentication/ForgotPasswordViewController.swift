//
//  ForgotPasswordViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    @IBOutlet weak var tfRecoveryEmail: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    
    var previousEmail: String = ""
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfRecoveryEmail.makeItThemeTF()
        buttonSend.makeItThemePrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        tfRecoveryEmail.placeholder = "forgot_password_recovery_email".localized()
        buttonSend.setTitle("forgot_password_send".localized(), for: .normal)
        
        
        self.navigationController?.navigationBar.isHidden = false
        
        tfRecoveryEmail.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        tfRecoveryEmail.text = previousEmail
        
        checkButton()
        
        buttonSend.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: FPEmailSentViewController.self)
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
    private func checkButton() {
        let email = tfRecoveryEmail.text ?? ""
        if !email.isEmpty && email.isValidEmail  {
            buttonSend.alpha = 1
            buttonSend.isEnabled = true
        }else {
            buttonSend.alpha = 0.4
            buttonSend.isEnabled = false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkButton()
    }
}

extension ForgotPasswordViewController {
    
    func setupNavigation() {
        self.setBackButton(.appBlue).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
