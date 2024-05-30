//
//  RegisterViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var labelPersonalDetails: UILabel!
    
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var labelFatherName: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    @IBOutlet weak var tfDob: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    @IBOutlet weak var buttonSubmit: UIButton!
    
    private var selectedOption = ""
    private var dropDownListGender = ["Male", "Female", "Other"]
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tfFullName.makeItThemeTF()
        labelFatherName.makeItThemeTF()
        tfGender.makeItThemeTF()
        tfDob.makeItThemeTF()
        tfEmail.makeItThemeTF()
        tfPassword.makeItThemeTF()
        tfConfirmPassword.makeItThemeTF()
        
        buttonSubmit.makeItThemePrimary()
        
        imageProfile.setRoundBorderColor(.appBlue, 1, imageProfile.viewWidth.half)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = false
        
        setUpPickerViewGender()
        setUpPickerViewDOB()
        
        imageProfile.addTapGestureRecognizer{[weak self] in self?.setUpPhoto()}
        
        labelPersonalDetails.text = "register_personal_information".localized()
        buttonSubmit.setTitle("register_submit".localized(), for: .normal)
        
        buttonSubmit.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
            contentVC.messageThankYou = .registeredSuccess
            contentVC.moveThankYou = .home
            openModuleOverFullScreen(controller: contentVC)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}

extension RegisterViewController {
    
    func setupNavigation() {
        self.setTitle("register_title".localized())
        self.setNavBarColor(.appBlue)
        self.setBackButton(.appLight).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterViewController {
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

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            alert.popoverPresentationController?.sourceView = imageProfile
            alert.popoverPresentationController?.sourceRect = imageProfile.bounds
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
        imageProfile.image = image
//        isImageUpdatedUploaded = true
    }
}
