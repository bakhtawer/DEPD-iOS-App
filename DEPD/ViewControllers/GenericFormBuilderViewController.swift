//
//  GenericFormBuilderViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/09/2024.
//

import UIKit

class GenericFormBuilderViewController: BaseViewController {
    @IBOutlet weak var tfCnic: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfDisability: UITextField!
    @IBOutlet weak var tfDistrict: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    @IBOutlet weak var tfContactNo: UITextField!
    @IBOutlet weak var tfTypeOfCompllain: UITextField!
    @IBOutlet weak var tvMessage: PlaceholderTextView!
    @IBOutlet weak var buttonUploadRecord: UIButton!
    @IBOutlet weak var buttonSubmit: DEPDButton!
    
    @IBOutlet weak var viewTFTypeOfComplain: UIView!
    
    enum GenericFormType {
        case suggestions, complain
    }
    
    var screenType: GenericFormType = .complain
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutSubviews()
        view.layoutIfNeeded()
        view.setNeedsDisplay()
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        buttonSubmit.addTapGestureRecognizer {[weak self] in
            self?.formateData()
        }
    }
    
    private func formateData() {
        
        let tempCnic = tfCnic.text ?? ""
        let tempFullName = tfFullName.text ?? ""
        let tempDisability = tfDisability.text ?? ""
        let tempDistrict = tfDistrict.text ?? ""
        let tempGender = tfGender.text ?? ""
        let tempContactNo = tfContactNo.text ?? ""
        let tempTypeOfCompllain = tfTypeOfCompllain.text ?? ""
        let tempMessage = tvMessage.text ?? ""
        
        SMM().showStatusInfo(message: "Waiting for API")
        
//        guard let fullName = tempFullName,
//              let lastName = tempFatherName,
//              let cnic = tempCnic,
//              let password = tempPassword,
//              let confirmPassword = tempConfirmPassword,
//              !fullName.isEmpty,
//              !lastName.isEmpty,
//              !cnic.isEmpty
//        else { SMM.shared.showStatusInfo(message: "Missing Info"); return }
    }
    
    private func setView() {
        tfCnic.makeItThemeTF()
        tfFullName.makeItThemeTF()
        tfDisability.makeItThemeTF()
        tfDistrict.makeItThemeTF()
        tfGender.makeItThemeTF()
        tfContactNo.makeItThemeTF()
        tfTypeOfCompllain.makeItThemeTF()
        tvMessage.backgroundColor = .appLight
        buttonSubmit.makeItTheme(text: "register_submit".localized(),
                                 .bold, 18, .appLight)
        
        switch screenType {
        case .suggestions:
            viewTFTypeOfComplain.isHidden = true
        case .complain:
            viewTFTypeOfComplain.isHidden = false
        }
    }
}

extension GenericFormBuilderViewController {
    func setupNavigation() {
        switch screenType {
        case .suggestions:
            self.setTitle("help_suggestions".localized())
        case .complain:
            self.setTitle("help_complain".localized())
        }
        self.setNavBarColor(.appBG)
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.appDarkBG).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
