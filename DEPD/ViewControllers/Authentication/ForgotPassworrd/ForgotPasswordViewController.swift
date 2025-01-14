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
    
    @IBOutlet weak var labelEnterCNIC: UILabel!
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfRecoveryEmail.makeItThemeTF()
        buttonSend.makeItThemePrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        tfRecoveryEmail.placeholder = "cnic".localized()
        buttonSend.setTitle("forgot_password_send".localized(), for: .normal)
        tfRecoveryEmail.keyboardType = .numberPad
        labelEnterCNIC.text = "Enter CNIC".localized()
        labelEnterCNIC.makeItTheme(.bold, 20, .appBlue, .center)
        
        self.navigationController?.navigationBar.isHidden = false
        
        tfRecoveryEmail.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
//        tfRecoveryEmail.text = previousEmail
        
        checkButton()
        
        buttonSend.addTapGestureRecognizer {[weak self] in
            guard let cnic = Int(self?.tfRecoveryEmail.text ?? "")  else {return}
            self?.showLoadingIndicator()
            USM.shared.forgetPassword(Cnic: cnic) {[weak self] status in
                if status { self?.goToNext() }
                self?.hideLoadingIndicator()
            }
        }
    }
    
    private func goToNext() {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: ForgotPOTPViewController.self)
            view.previousEmail = self?.tfRecoveryEmail.text ?? ""
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    private func checkButton() {
        let email = tfRecoveryEmail.text ?? ""
        if !email.isEmpty {
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
