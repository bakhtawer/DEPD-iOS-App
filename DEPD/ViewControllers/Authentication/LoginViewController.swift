//
//  LoginViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit
import AVFoundation

enum LoginScreenType {
    case student
    case jobSeeker
    case companyHiring
    case institute
}

class LoginViewController: BaseViewController {
    
    var screenType: LoginScreenType = .student
    
    let service = APIService()
    
    @IBOutlet weak var labelLoginTitle: UILabel!
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    @IBOutlet weak var labelForgotPassword: UILabel!
    
    @IBOutlet weak var labelLoginAsGust: UILabel!
    
    private var userType: UserType = UserType.Student
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setView()
    }
    
    private func setView() {
        tfUserName.makeItThemeTF()
        tfPassword.makeItThemeTF()
        
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            UITextField.appearance().textAlignment = .right
        } else {
            UITextField.appearance().textAlignment = .left
        }
        
        buttonLogin.makeItThemePrimary()
        buttonRegister.makeItThemePrimary()
        
        tfUserName.isAccessibilityElement = true
        tfPassword.isAccessibilityElement = true
        buttonLogin.isAccessibilityElement = true
        buttonRegister.isAccessibilityElement = true
        
        labelLoginTitle.makeItTheme(.light, 20, .textDark)
        labelLoginAsGust.makeItTheme(.regular, 14, .appGreen)
        
        switch screenType {
        case .student:
            tfUserName.text = "4111111111111"
            tfPassword.text = "12345678"
            setUpStudent()
        case .jobSeeker:
            setUpJobSeeker()
        case .companyHiring:
            setUpCompanyHiring()
        case .institute:
            tfUserName.text = "4222222222222"
            tfPassword.text = "12345678"
            setUpInstitute()
        }
        
        tfUserName.placeholder = "cnic".localized()
        tfPassword.placeholder = "login_password".localized()
        
        tfUserName.accessibilityLabel = "login_user_name".localized()
        tfPassword.accessibilityLabel = "login_password".localized()
        
        buttonLogin.accessibilityLabel = "press login and go to next screen".localized()
        buttonRegister.accessibilityLabel = "login_register".localized()
        
        labelLoginAsGust.text = "continue_as_guest".localized()
        labelForgotPassword.text = "login_forgot_password".localized()
        
        labelForgotPassword.makeItTheme(.regular, 12, .appBlue, 14.06)
        
        buttonLogin.setTitle("login_login".localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
        labelForgotPassword.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: ForgotPasswordViewController.self)
            view.previousEmail = self?.tfUserName.text ?? ""
            self?.navigationController?.pushViewController(view, animated: true)
        }
        
        tfUserName.delegate = self
        tfUserName.keyboardType = .numberPad
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
    }
    
    private func setUpStudent() {
        
        labelLoginTitle.text = "login_as_student".localized()
        
        buttonLogin.setTitle("login_login".localized(), for: .normal)
        buttonRegister.setTitle("register_as_student".localized(), for: .normal)

        buttonLogin.addTapGestureRecognizer {[weak self] in
            guard let cnic = self?.tfUserName.text, 
                    cnic.count > 10
            else {
                SMM().showError(title: "Wrong Info", message: "Please provide correct CNIC number")
                return
            }
            guard let password = self?.tfPassword.text,
                  password.count > 1
            else {
                SMM().showError(title: "Wrong Info", message: "Please provide correct Password")
                return
            }
            APPMetaDataHandler.shared.userType = .Student
            self?.login(email: cnic,
                        Password:password)
        }
        
        buttonRegister.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAndroidViewController.self)
            view.userType = .Student
            openModuleOnNavigation(from: self, controller: view)
        }
        
        labelLoginAsGust.addTapGestureRecognizer {
            APPMetaDataHandler.shared.userType = .StudentGuest
            Bootstrapper.createHome(.StudentGuest)
        }
    }
    private func setUpJobSeeker() {
        labelLoginTitle.text = "login_as_job_seeker".localized()
        buttonRegister.setTitle("register_as_job_seeker".localized(), for: .normal)
    }
    private func setUpCompanyHiring() {
        labelLoginTitle.text = "login_as_company_hiring_manager".localized()
        buttonRegister.setTitle("register_as_company_hiring_manager".localized(), for: .normal)
    }
    private func setUpInstitute() {
        labelLoginTitle.text = "login_as_institute".localized()
        buttonRegister.setTitle("register_as_institute".localized(), for: .normal)
        labelLoginAsGust.isHidden = true
        
        
        buttonLogin.addTapGestureRecognizer {[weak self] in
            guard let cnic = self?.tfUserName.text,
                    cnic.count > 10
            else {
                SMM().showError(title: "Wrong Info", message: "Please provide correct CNIC number")
                return
            }
            guard let password = self?.tfPassword.text,
                  password.count > 1
            else {
                SMM().showError(title: "Wrong Info", message: "Please provide correct Password")
                return
            }
            APPMetaDataHandler.shared.userType = .School
            self?.login(email: cnic,
                        Password:password)
        }
        
        buttonRegister.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAndroidViewController.self)
            view.userType = .Student
            APPMetaDataHandler.shared.userType = .StudentGuest
            openModuleOnNavigation(from: self, controller: view)
        }
        
    }
    
    func onSayMeSomething() {
        let utterance = AVSpeechUtterance(string: "Wow! I can speak!")
        utterance.pitchMultiplier = 1.3
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate * 1.5
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    func isVoiceOverRunning() -> Bool {
        return UIAccessibility.isVoiceOverRunning
    }
    
    func openVoiceOverSettings() {
        if let url = URL(string: "App-Prefs:root=ACCESSIBILITY&path=VOICEOVER") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

extension LoginViewController {
    private func login(email: String, Password: String) {
        let request = Endpoint.login(email: email, password: Password).request!
        showLoadingIndicator(withDimView: true)
        service.makeRequest(with: request, respModel: ApiResponse<User>.self) {[weak self] userResponse, error in
            self?.hideLoadingIndicator()
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let user = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            UserSessionManager.shared.setUser(user: user)
            DispatchQueue.main.async { Bootstrapper.createHome()}
        }
    }
}

extension LoginViewController {
    func setupNavigation() {
        setLogo()
        self.setBackButton(.appBlue).addTapGestureRecognizer {
            Bootstrapper.createInclusiveScreen()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Combine the existing text with the new text
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)

        // Allow only digits and limit to 16 characters
        let isNumeric = prospectiveText.isEmpty || (prospectiveText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil)
        return isNumeric && prospectiveText.count <= 16
    }
}
