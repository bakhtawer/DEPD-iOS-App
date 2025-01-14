//
//  ForgotPOTPViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/01/2025.
//

import UIKit

class ForgotPOTPViewController: BaseViewController {
    
    @IBOutlet weak var tfOTP: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    
    @IBOutlet weak var labelEnterOPT: UILabel!
    var previousEmail: String = ""
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfOTP.makeItThemeTF()
        buttonSend.makeItThemePrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        tfOTP.placeholder = "OTP".localized()
        buttonSend.setTitle("forgot_password_send".localized(), for: .normal)
        tfOTP.keyboardType = .numberPad
        
        labelEnterOPT.text = "Enter OTP".localized()
        labelEnterOPT.makeItTheme(.bold, 20, .appBlue, .center)
        
        
        self.navigationController?.navigationBar.isHidden = false
        
        tfOTP.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
//        tfRecoveryEmail.text = previousEmail
        
        checkButton()
        
        buttonSend.addTapGestureRecognizer {[weak self] in
            guard let cnic = Int(self?.previousEmail ?? "") else {return}
            self?.showLoadingIndicator()
            USM.shared.verifyOtp(Cnic: cnic, Otp: self?.tfOTP.text ?? "") {[weak self] status in
                self?.hideLoadingIndicator()
                if status { self?.goToNext() }
            }
        }
    }
    
    
    private func checkButton() {
        let email = tfOTP.text ?? ""
        if !email.isEmpty {
            buttonSend.alpha = 1
            buttonSend.isEnabled = true
        }else {
            buttonSend.alpha = 0.4
            buttonSend.isEnabled = false
        }
    }
    
    private func goToNext() {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: ForgotPEnterPViewController.self)
            view.otp = self?.tfOTP.text ?? ""
            view.cnic = self?.previousEmail ?? ""
            self?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkButton()
    }
}

extension ForgotPOTPViewController {
    
    func setupNavigation() {
        self.setBackButton(.appBlue).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
