//
//  SchoolStudentDetailViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 15/09/2024.
//

import UIKit

class SchoolStudentDetailViewController: BaseViewController {
    @IBOutlet weak var viewBottom: BottomView!
    private let service = APIService()
    var selectedStudent: InstituteHomeModel?
    
    
    @IBOutlet weak var imageStudent: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelProfileComplete: UILabel!
    @IBOutlet weak var labelPersonalDetails: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
    @IBOutlet weak var buttonCertificate: DEPDButton!
    
    @IBOutlet weak var viewDash: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setView()
        guard let selectedStudent = selectedStudent else { return }
        buttonCertificate.addTapGestureRecognizer {[weak self] in
            guard let certificate = self?.selectedStudent?.DisabilityCertificateURL?.convertToHttps() else { return }
            let webVC = DEPDWebViewController()
            webVC.urlString = certificate
            openModuleOnNavigation(from: self, controller: webVC)
        }
        guard let image = URL(string: selectedStudent.ProfilePictureURL?.convertToHttps() ?? "") else { return }
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
                                      .bold, 16, .appLight)
        
        imageStudent.roundCorner(withRadis: imageStudent.viewHeight.half)
        labelName.makeItTheme(.bold, 16, .textDark)
        labelLocation.makeItTheme(.regular, 12, .textDark)
        labelProfileComplete.makeItTheme(.regular, 12, .appBlue)
        
        labelPersonalDetails.makeItTheme(.bold, 16, .textDark)
        labelDetails.makeItTheme(.regular, 14, .textDark, 20)
        
        viewDash.roundCorner(withRadis: viewDash.viewHeight.half)
        
        labelDetails.textAlignment = .left
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            labelDetails.textAlignment = .right
        }
        
        labelPersonalDetails.text = "personal_details".localized()
        
        guard let selectedStudent = selectedStudent else { return }
        let fullName = (selectedStudent.student?.FirstName ?? "") + " " + (selectedStudent.student?.LastName ?? "")
        labelName.text = fullName
        labelLocation.text = selectedStudent.District
        labelProfileComplete.text = "\(Int(selectedStudent.ProfileCompletion?.rounded() ?? 0))% \("profile_completed".localized())"
        let name = "\("name".localized()): \(fullName)\n"
        let cnic = "\("cnic".localized()): \(selectedStudent.student?.CNIC ?? "N/A")\n"
        let contactNumber = "\("contact_number".localized()): \(selectedStudent.student?.ContactNo ?? "N/A")\n"
        let disability = "\("select_disablility".localized()): \(selectedStudent.DisabilityName ?? "N/A")"
        let fatherName = "\("father_name".localized()): N/A\n"
        let gender = "\("gender".localized()): \(selectedStudent.Gender ?? "N/A")\n"
        let address = "\("address".localized()): \(selectedStudent.District ?? "N/A")\n"
        let email = "\("email".localized()): N/A\n"
        labelDetails.text = "\(name)\(cnic)\(contactNumber)\(disability)\(fatherName)\(gender)\(address)\(email)"
    }
}

extension SchoolStudentDetailViewController {
    
    func setupNavigation() {
        self.setTitle("applicant_profile".localized())
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
