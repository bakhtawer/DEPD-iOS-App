//
//  ApplicantProfileViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 30/12/2024.
//

import UIKit

class ApplicantProfileViewController: BaseViewController {
    @IBOutlet weak var viewBottom: BottomView!
    private let service = APIService()
    var selectedJobEmployee: CompanyJobModel?
    
    @IBOutlet weak var imageStudent: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelProfileComplete: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
    @IBOutlet weak var buttonCertificate: DEPDButton!
    @IBOutlet weak var buttonDownloadCV: DEPDButton!
    
    private var selectedUser: User?
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelContactNo: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var viewEducation: UIView!
    @IBOutlet weak var labelEducation: UILabel!
    
    @IBOutlet weak var viewSkills: UIView!
    @IBOutlet weak var labelSkills: UILabel!
    
    @IBOutlet weak var viewWorkExperience: UIView!
    @IBOutlet weak var labelWorkExperience: UILabel!
    
    @IBOutlet weak var viewAge: UIView!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelAgeDetails: UILabel!
    
    @IBOutlet weak var viewDisability: UIView!
    @IBOutlet weak var labelDisability: UILabel!
    @IBOutlet weak var labelDisabilityDetails: UILabel!
    
    @IBOutlet weak var buttonAccept: DEPDButton!
    @IBOutlet weak var buttonReject: DEPDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setView()
        guard let selectedStudent = selectedJobEmployee else { return }
        
        self.showLoadingIndicator(withDimView: true)
        USM.shared.getJobSeeker(userID: selectedStudent.Id!) {[weak self] user in
            DispatchQueue.main.async {[weak self] in
                self?.hideLoadingIndicator()
                self?.selectedUser = user
                self?.setView()
            }
        }
        
        buttonCertificate.addTapGestureRecognizer {[weak self] in
            guard let certificate = self?.selectedUser?.jobSeekerDetailInfo?.disabilityCertificateURL?.convertToHttps() else { return }
            let webVC = DEPDWebViewController()
            webVC.urlString = certificate
            openModuleOnNavigation(from: self, controller: webVC)
        }
        buttonDownloadCV.addTapGestureRecognizer {[weak self] in
            guard let certificate = self?.selectedUser?.jobSeekerDetailInfo?.cvFileURL?.convertToHttps() else { return }
            let webVC = DEPDWebViewController()
            webVC.urlString = certificate
            openModuleOnNavigation(from: self, controller: webVC)
        }
        
        viewEducation.addTapGestureRecognizer {[weak self] in
            self?.setUpEducation()
        }
        viewSkills.addTapGestureRecognizer {[weak self] in
            self?.setUpSkills()
        }
        viewWorkExperience.addTapGestureRecognizer {[weak self] in
            self?.setUpWorkExperince()
        }
        
        buttonAccept.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .acceptJobApplication
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonReject.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .rejectJobApplication
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        guard let image = URL(string: selectedStudent.profilePicture?.convertToHttps() ?? "") else { return }
        imageStudent.contentMode = .scaleAspectFill
        imageStudent.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
        setupNavigation()
    }
    
    private func setView() {
        buttonCertificate.makeItTheme(text: "download_disability_certificate".localized(),
                                      .bold, 12, .appLight)
        buttonDownloadCV.makeItTheme(text: "download_cv".localized(),
                                      .bold, 12, .appBlue, .appLight)
        buttonAccept.makeItTheme(text: "accept".localized(),
                                      .bold, 12, .appLight)
        buttonReject.makeItTheme(text: "reject".localized(),
                                 .bold, 12, .appBlue, .appLight)
        
        imageStudent.roundCorner(withRadis: imageStudent.viewHeight.half)
        labelName.makeItTheme(.bold, 16, .textDark)
        labelLocation.makeItTheme(.regular, 12, .textDark)
        labelProfileComplete.makeItTheme(.regular, 12, .appBlue)
        
        labelDetails.textAlignment = .left
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            labelDetails.textAlignment = .right
        }
        
        guard let selectedApplicant = selectedUser else { return }
        let fullName = (selectedApplicant.firstName ?? "") + " " + (selectedApplicant.lastName ?? "")
        labelName.text = fullName
        labelLocation.text = selectedApplicant.jobSeekerDetailInfo?.address
        labelProfileComplete.text = "\(selectedApplicant.percentage ?? 0)% \("profile_completed".localized())"
        
        labelAgeDetails.text = "\(selectedApplicant.jobSeekerDetailInfo?.age ?? 0)"
        labelEmail.text = "\(selectedApplicant.jobSeekerDetailInfo?.emailAddress ?? "")"
        labelContactNo.text = "\(selectedApplicant.contactNo ?? "")"
        labelAddress.text = "\(selectedApplicant.jobSeekerDetailInfo?.address ?? "")"
        labelDisabilityDetails.text = AMDH.shared.getDisabilities(byID: selectedApplicant.jobSeekerDetailInfo?.disabilityId ?? 0)?.name
        
        labelDetails.text = selectedApplicant.jobSeekerDetailInfo?.aboutInfo?.aboutText ?? ""
        
        viewEducation.roundCorner(withRadis: 6)
        labelEducation.text = "education".localized()
        labelEducation.makeItTheme(.bold, 12)
        
        viewAge.roundCorner(withRadis: 6)
        labelAge.text = "age".localized()
        labelAge.makeItTheme(.bold, 12)
        labelAgeDetails.makeItTheme(.regular, 12, .appLight)
        
        viewSkills.roundCorner(withRadis: 6)
        labelSkills.text = "skills".localized()
        labelSkills.makeItTheme(.bold, 12)
        
        viewWorkExperience.roundCorner(withRadis: 6)
        labelWorkExperience.text = "experience".localized()
        labelWorkExperience.makeItTheme(.bold, 12)
        
        viewDisability.roundCorner(withRadis: 6)
        labelDisability.text = "disability".localized()
        labelDisability.makeItTheme(.bold, 12)
        labelDisabilityDetails.makeItTheme(.regular, 12, .appLight)
        
    }
}

extension ApplicantProfileViewController {
    
    func setupNavigation() {
        self.setTitle("applicant_profile".localized())
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension ApplicantProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func setUpEducation() {
        let tempTF = UITextField(frame: CGRect(x: -100, y: -200, width: 20, height: 20))
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 920
        
        // Set the picker as the input view for the textField
        tempTF.inputView = pickerView
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tempTF.inputAccessoryView = toolbar
        
        self.view.addSubview(tempTF)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            tempTF.becomeFirstResponder()
        }
    }
    
    private func setUpSkills() {
        let tempTF = UITextField(frame: CGRect(x: -100, y: -200, width: 20, height: 20))
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 930
        
        // Set the picker as the input view for the textField
        tempTF.inputView = pickerView
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tempTF.inputAccessoryView = toolbar
        
        self.view.addSubview(tempTF)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            tempTF.becomeFirstResponder()
        }
    }
    
    private func setUpWorkExperince() {
        let tempTF = UITextField(frame: CGRect(x: -100, y: -200, width: 20, height: 20))
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 940
        
        // Set the picker as the input view for the textField
        tempTF.inputView = pickerView
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tempTF.inputAccessoryView = toolbar
        
        self.view.addSubview(tempTF)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            tempTF.becomeFirstResponder()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 920: return selectedUser?.jobSeekerDetailInfo?.jobSeekerEducationInfo?.count ?? 0
        case 930: return selectedUser?.jobSeekerDetailInfo?.jobSeekerTechnicalSkill?.count ?? 0
        case 940: return selectedUser?.jobSeekerDetailInfo?.jobSeekerWorkExperience?.count ?? 0
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 920: return "\(selectedUser?.jobSeekerDetailInfo?.jobSeekerEducationInfo?[row].institution ?? "N/A") - \(selectedUser?.jobSeekerDetailInfo?.jobSeekerEducationInfo?[row].degree ?? "N/A")"
        case 930: return selectedUser?.jobSeekerDetailInfo?.jobSeekerTechnicalSkill?[row].skillDescription ?? "N/A"
        case 940: return "\(selectedUser?.jobSeekerDetailInfo?.jobSeekerWorkExperience?[row].companyName ?? "N/A") - \(selectedUser?.jobSeekerDetailInfo?.jobSeekerWorkExperience?[row].jobTitle ?? "N/A") - \(selectedUser?.jobSeekerDetailInfo?.jobSeekerWorkExperience?[row].duration ?? "N/A")"
        default: return APPMetaDataHandler.shared.getPreviousClasses()[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    @objc func doneButtonTapped() {
        UIViewController.top().view.endEditing(true)
    }
}
