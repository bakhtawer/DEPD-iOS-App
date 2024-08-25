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
        
        labelLoginTitle.makeItTheme(.light, 20, .textDark)
        labelLoginAsGust.makeItTheme(.regular, 20, .appGreen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch screenType {
        case .student:
            setUpStudent()
        case .jobSeeker:
            setUpJobSeeker()
        case .companyHiring:
            setUpCompanyHiring()
        case .institute:
            setUpInstitute()
        }
        
        labelLoginAsGust.text = "continue_as_guest".localized()
        
        tfUserName.placeholder = "login_user_name".localized()
        tfPassword.placeholder = "login_password".localized()
        
        tfUserName.accessibilityLabel = "login_user_name".localized()
        tfPassword.accessibilityLabel = "login_password".localized()
        
        buttonLogin.accessibilityLabel = "press login and go to next screen".localized()
        buttonRegister.accessibilityLabel = "login_register".localized()
        
        labelForgotPassword.text = "login_forgot_password".localized()
        
        
//        labelForgotPassword.addTapGestureRecognizer {[weak self] in
//            self?.onSayMeSomething()
//            
//            if !(self?.isVoiceOverRunning() ?? true) {
//                self?.openVoiceOverSettings()
//            }
//            let storyboard = getStoryBoard(.main)
//            let view = storyboard.instantiateViewController(ofType: ForgotPasswordViewController.self)
//            view.previousEmail = self?.tfUserName.text ?? ""
//            self?.navigationController?.pushViewController(view, animated: true)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLogo()
    }
    
    private func setUpStudent() {
        
        labelLoginTitle.text = "login_as_student".localized()
        
        buttonLogin.setTitle("login_login".localized(), for: .normal)
        buttonRegister.setTitle("register_as_student".localized(), for: .normal)

        buttonLogin.addTapGestureRecognizer {[weak self] in
            self?.login(email: self?.tfUserName.text ?? "",
                        Password: self?.tfPassword.text ?? "")
        }
        
        buttonRegister.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterSimpleViewController.self)
            view.userType = .Student
            openModuleOnNavigation(from: self, controller: view)
        }
        
        labelLoginAsGust.addTapGestureRecognizer { Bootstrapper.createHome() }
        
        labelForgotPassword.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: ForgotPasswordViewController.self)
            view.previousEmail = self?.tfUserName.text ?? ""
            self?.navigationController?.pushViewController(view, animated: true)
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
