//
//  RegisterSimpleViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/07/2024.
//

import UIKit

struct SignUpCredentials: Codable {
    let FirstName: String
    let LastName: String
    let CNIC: String
    let ContactNo: String
    let Password: String
    let Email: String
    let UserTypeId: Int
}

class RegisterSimpleViewController: BaseViewController {
    
    @IBOutlet weak var labelPersonalDetails: UILabel!
    
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var labelFatherName: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    @IBOutlet weak var tfDob: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfCnic: UITextField!
    
    @IBOutlet weak var buttonSubmit: UIButton!
    
    private var selectedOption = ""
    private var dropDownListGender = ["Male", "Female", "Other"]
    
    @IBOutlet weak var btnUploadTopPicture: UIButton!
    @IBOutlet weak var btnUploadPicture: UIButton!
    @IBOutlet weak var btnUploadForm: UIButton!
    
    @IBOutlet weak var viewBottom: BottomView!
    
    let service = APIService()
    
    var userType: UserType = UserType.Student
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfFullName.makeItThemeTF()
        labelFatherName.makeItThemeTF()
        tfGender.makeItThemeTF()
        tfDob.makeItThemeTF()
        tfEmail.makeItThemeTF()
        tfPassword.makeItThemeTF()
        tfConfirmPassword.makeItThemeTF()
        tfCnic.makeItThemeTF()
        
        btnUploadForm.makeItThemeGreenPrimary()
        btnUploadTopPicture.makeItThemeGreenPrimary()
        btnUploadPicture.makeItThemeGreenPrimary()
        
        buttonSubmit.makeItThemePrimary()
        
        viewBottom.setLanguage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appBG
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = false
        
        setUpPickerViewGender()
        setUpPickerViewDOB()
        
        tfEmail.keyboardType = .numberPad
        tfFullName.placeholder = "First Name"
        labelFatherName.placeholder = "Last Name"
        
//        imageProfile.addTapGestureRecognizer{[weak self] in self?.setUpPhoto()}
        
        labelPersonalDetails.text = "register_personal_information".localized()
        buttonSubmit.setTitle("register_submit".localized(), for: .normal)
        
        buttonSubmit.addTapGestureRecognizer {[weak self] in
            self?.signUp()
        }
    }
    
    private func signUp() {
        let tempFullName = tfFullName.text
        let tempFatherName = labelFatherName.text
        let tempGender = tfGender.text
        let tempDob = tfDob.text
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
                                      ContactNo: tempEmail ?? "",
                                      Password: password,
                                      Email: "",
                                      UserTypeId: userType.rawValue)
        register(creds: creds)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}

extension RegisterSimpleViewController {
    func setupNavigation() {
        self.setTitle("register_title".localized())
        self.setNavBarColor(.appBG)
        self.setBackButton(.darkText).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterSimpleViewController {
    private func setUpPickerViewGender() {
        let picker: UIPickerView
        picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        picker.backgroundColor = .appBG
        
        picker.delegate = self
        picker.dataSource = self
        
        picker.tag = 901
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .appBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker(_:)))
        doneButton.tag = 901
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker(_:)))
        cancelButton.tag = 901
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        

        selectedOption = "Male"
        tfGender?.inputView = picker
        tfGender?.inputAccessoryView = toolBar
    }
    
    private func setUpPickerViewDOB() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        tfDob.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func cancelPicker(_ sender: UIButton) {
        self.view.endEditing(true)
        
        print(sender.tag)
    }
    
    @objc func donePicker(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 901 {
            tfGender.text = selectedOption
            return
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        tfDob.text = dateFormatter.string(from: sender.date)
    }
}

extension RegisterSimpleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 901 {
            return dropDownListGender.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 901 {
            return dropDownListGender[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 901 {
            selectedOption = dropDownListGender[row]
            return
        }
    }
}

extension RegisterSimpleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setUpPhoto() {
        
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Take photo", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            DispatchQueue.main.async {[weak self] in
                self?.setUpPicker(sourceType: .camera)
            }
        }))
        //            alert.addAction(UIAlertAction(title: "Camera roll", style: .default , handler:{ (UIAlertAction)in
        //                DispatchQueue.main.async {[weak self] in
        //                    self?.setUpPicker(sourceType: .camera)
        //                }
        //            }))
        alert.addAction(UIAlertAction(title: "Photo library", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {[weak self] in
                self?.setUpPicker(sourceType: .photoLibrary)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alert.popoverPresentationController?.sourceView = buttonSubmit
            alert.popoverPresentationController?.sourceRect = buttonSubmit.bounds
            alert.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    private func setUpPicker(sourceType: UIImagePickerController.SourceType) {
        let vc = UIImagePickerController()
        vc.sourceType = sourceType
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

//        profileImage = image
//        imageProfile.image = image
//        isImageUpdatedUploaded = true
    }
}

extension RegisterSimpleViewController {
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
            DispatchQueue.main.async { Bootstrapper.createHome()}
        }
    }
}
