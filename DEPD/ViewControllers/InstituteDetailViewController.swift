//
//  InstituteDetailViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/07/2024.
//

import UIKit

class InstituteDetailViewController: BaseViewController {
    
    @IBOutlet weak var viewBottom: BottomView!
    var selectedInstitute: InstituteModel?
    private let service = APIService()
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAdmin: UIImageView!
    @IBOutlet weak var labelTopLocation: UILabel!
    
    @IBOutlet weak var labelSchoolName: UILabel!
    @IBOutlet weak var labelSchoolLocation: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelAddressFull: UILabel!
    
    @IBOutlet weak var labelNumberOfTeachers: UILabel!
    @IBOutlet weak var labelNumberOfSeats: UILabel!
    
    @IBOutlet weak var bgMaterial: UIView!
    @IBOutlet weak var iconMaterial: UIImageView!
    
    @IBOutlet weak var bgtrainingMaterial: UIView!
    @IBOutlet weak var iconTrainingMaterial: UIImageView!
    
    @IBOutlet weak var buttonAdmission: UIButton!
    @IBOutlet weak var buttonCancel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        
        guard let data = selectedInstitute else { return }
        
        
        labelName.text = ""
        labelTopLocation.text = ""
        
        labelSchoolName.text = data.SchoolName
        labelSchoolLocation.text = data.Location
        
        labelPhone.text = data.ContactNumber
        labelEmail.text = data.EmailAddress
        labelAddressFull.text = data.Location
        
        labelNumberOfTeachers.text = "\(data.NumOfTrainedTeachers ?? 0)"
        labelNumberOfSeats.text = "\(data.NumberOfSeats ?? 0)"
        
        let accessibilityMaterial = data.HasAccessibilityMaterial ?? false
        let trainingMaterial = data.HasTrainingMaterial ?? false
        
        if accessibilityMaterial {
            bgMaterial.backgroundColor = .appGreen
            iconMaterial.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        } else {
            bgMaterial.backgroundColor = .appError
            iconMaterial.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
        }
        
        if trainingMaterial {
            bgtrainingMaterial.backgroundColor = .appGreen
            iconTrainingMaterial.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        } else {
            bgtrainingMaterial.backgroundColor = .appError
            iconTrainingMaterial.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
        }
        
        iconMaterial.tintColor = .white
        iconTrainingMaterial.tintColor = .white
        
        buttonAdmission.addTapGestureRecognizer {[weak self] in
            let request = Endpoint.applyForSchool(schoolID: data.InstituteId ?? -1).request!
            self?.service.makeRequest(with: request, respModel: ApiResponse<String>.self) {[weak self] userResponse, error in
                if let error = error { print("DEBUG PRINT:", error); return }
                if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
                
                
                let storyboard = getStoryBoard(.main)
                let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                contentVC.messageThankYou = .yourSchoolHasBeen("hello")
                contentVC.moveThankYou = .home
                openModuleOverFullScreen(controller: contentVC)
            }
        }
        
    }
}
extension InstituteDetailViewController {
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.appBlue).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
