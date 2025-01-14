//
//  ForgotPEnterPViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/01/2025.
//

import UIKit

class ForgotPEnterPViewController: BaseViewController {
    
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfNewPasswordConfirm: UITextField!
    
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var labelEnterPassword: UILabel!
    
    var cnic: String = ""
    var otp: String = ""
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfNewPassword.makeItThemeTF()
        tfNewPasswordConfirm.makeItThemeTF()
        buttonSend.makeItThemePrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        tfNewPassword.placeholder = "login_password".localized()
        tfNewPasswordConfirm.placeholder = "confirm_password".localized()
        buttonSend.setTitle("forgot_password_send".localized(), for: .normal)
        
        labelEnterPassword.text = "Enter Password".localized()
        labelEnterPassword.makeItTheme(.bold, 20, .appBlue, .center)
        
        tfNewPassword.isSecureTextEntry = true
        tfNewPasswordConfirm.isSecureTextEntry = true
        
        self.navigationController?.navigationBar.isHidden = false
        
        tfNewPassword.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                for: .editingChanged)
        tfNewPasswordConfirm.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                       for: .editingChanged)
        
        checkButton()
        
        buttonSend.addTapGestureRecognizer {[weak self] in
            guard let cnic = Int(self?.cnic ?? "") else {return}
            self?.showLoadingIndicator()
            USM.shared.resetPassword(Cnic: cnic,
                                     Otp: self?.otp ?? "",
                                     Pasword: self?.tfNewPassword.text ?? "") {[weak self] status in
                if status { self?.goToNext() }
                self?.hideLoadingIndicator()
            }
            
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: FPEmailSentViewController.self)
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    private func goToNext() {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: FPEmailSentViewController.self)
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
    private func checkButton() {
        let email = tfNewPassword.text ?? ""
        let emailConfirm = tfNewPasswordConfirm.text ?? ""
        if !email.isEmpty && !emailConfirm.isEmpty && emailConfirm == email {
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

extension ForgotPEnterPViewController {
    
    func setupNavigation() {
        self.setBackButton(.appBlue).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
