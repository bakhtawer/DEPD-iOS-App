//
//  RegisterAndroidViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/08/2024.
//

import UIKit

class RegisterAndroidViewController: BaseViewController {
    
    @IBOutlet weak var tfCnic: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var labelFatherName: UITextField!
    @IBOutlet weak var labelContactNo: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!

    @IBOutlet weak var buttonSubmit: UIButton!
    
    @IBOutlet weak var viewBottom: BottomView!
    
    let service = APIService()
    
    var userType: UserType = UserType.Student
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

        
        viewBottom.setLanguage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appBG
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = false
        
        tfCnic.keyboardType = .numberPad
        labelContactNo.keyboardType = .numberPad
        tfEmail.keyboardType = .numberPad
        tfPassword.isSecureTextEntry = true
        tfConfirmPassword.isSecureTextEntry = true
        
        setUpView()
        
        buttonSubmit.addTapGestureRecognizer {[weak self] in
            self?.signUp()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    private func setUpView() {
        tfCnic.placeholder = "cnic".localized()
        tfFullName.placeholder = "first_name".localized()
        labelFatherName.placeholder = "last_name".localized()
        tfEmail.placeholder = "email".localized()
        labelContactNo.placeholder = "contact_number".localized()
        tfPassword.placeholder = "login_password".localized()
        tfConfirmPassword.placeholder = "confirm_password".localized()
        
        tfCnic.makeItThemeTF()
        tfEmail.makeItThemeTF()
        tfFullName.makeItThemeTF()
        labelFatherName.makeItThemeTF()
        labelContactNo.makeItThemeTF()
        tfPassword.makeItThemeTF()
        tfConfirmPassword.makeItThemeTF()

        buttonSubmit.makeItThemePrimary()
        
        viewBottom.setLanguage()
        
        buttonSubmit.setTitle("register_title".localized(), for: .normal)
    }
    
    private func signUp() {
        let tempFullName = tfFullName.text
        let tempFatherName = labelFatherName.text
        let tempContactNo = labelContactNo.text
        let tempEmail = tfEmail.text
        let tempPassword = tfPassword.text
        let tempConfirmPassword = tfConfirmPassword.text
        let tempCnic = tfCnic.text
        
        guard let fullName = tempFullName,
              let lastName = tempFatherName,
              let cnic = tempCnic,
              let password = tempPassword,
              let confirmPassword = tempConfirmPassword,
              !fullName.isEmpty,
              !lastName.isEmpty,
              !cnic.isEmpty
        else { SMM.shared.showStatusInfo(message: "Missing Info"); return }
        
        guard password == confirmPassword
        else { SMM.shared.showStatusInfo(message: "Password Don't Match"); return }
    
        let creds = SignUpCredentials(FirstName: fullName,
                                      LastName: lastName,
                                      CNIC: cnic,
                                      ContactNo: tempContactNo ?? "",
                                      Password: password,
                                      Email: tempEmail ?? "",
                                      UserTypeId: userType.rawValue)
        register(creds: creds)
        
        let storyboard = getStoryBoard(.main)
        let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
        contentVC.messageThankYou = .registeredSuccess
        contentVC.moveThankYou = .home
        openModuleOverFullScreen(controller: contentVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}

extension RegisterAndroidViewController {
    func setupNavigation() {
        self.setTitle("register_title".localized())
        self.setNavBarColor(.appBG)
        self.setBackButton(.darkText).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterAndroidViewController {
    private func register(creds: SignUpCredentials) {
        let request = Endpoint.register(creds: creds).request!
        showLoadingIndicator(withDimView: true)
        service.makeRequest(with: request,
                            respModel: ApiResponse<User>.self) {[weak self] userResponse, error in
            self?.hideLoadingIndicator()
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let user = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            UserSessionManager.shared.setUser(user: user)
            DispatchQueue.main.async {Bootstrapper.createHome()}
        }
    }
}
