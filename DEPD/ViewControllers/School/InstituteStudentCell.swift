//
//  InstituteStudentCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/09/2024.
//

import UIKit
import Kingfisher

protocol InstituteStudentCellProtocol: NSObject {
    func viewProfile(id: InstituteHomeModel)
    func acceptAdmission(id: InstituteHomeModel)
    func rejectAdmission(id: InstituteHomeModel)
}

protocol EmployerPortalCellProtocol: NSObject {
    func viewProfile(id: Int)
    func acceptAdmission(id: Int)
    func rejectAdmission(id: Int)
}

class InstituteStudentCell: UICollectionViewCell {
    
    @IBOutlet weak var iconStudent: UIImageView!
    
    @IBOutlet weak var studentname: UILabel!
    @IBOutlet weak var disablility: UILabel!
    @IBOutlet weak var ageNGender: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var viewBg: UIView!
    
    static let reuseIdentifier: String = "InstituteStudentCell"
    
    @IBOutlet weak var buttonAccept: DEPDButton!
    @IBOutlet weak var ButtonReject: DEPDButton!
    @IBOutlet weak var buttonViewProfile: DEPDButton!
    
    @IBOutlet weak var labelStatus: UILabel!
    
    weak var delegate: InstituteStudentCellProtocol?
    weak var delegateEmployer: EmployerPortalCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: InstituteHomeModel) {
        
        studentname.text = (model.student?.FirstName ?? "") + " " + (model.student?.LastName ?? "")
        disablility.text = model.DisabilityName
        ageNGender.text = "\(model.Gender ?? "")"
        location.text = model.District
        
        labelStatus.makeItTheme(.bold, 12, .appLight)
        studentname.makeItTheme(.bold, 16, .textDark)
        disablility.makeItTheme(.regular, 12, .appBlue)
        ageNGender.makeItTheme(.regular, 12, .appBlue)
        location.makeItTheme(.regular, 12, .appBlue)
        
        viewBg.applyShadow()
        iconStudent.roundCorner(withRadis: iconStudent.viewWidth.half)
        
        buttonAccept.makeItTheme(text: "accept".localized(), .bold, 12, .appLight, .appGreen)
        buttonAccept.makeButtonIcon(named: "checkmark.circle")
        buttonAccept.makeHight(height: 40, false, true)
        
        ButtonReject.makeItTheme(text: "reject".localized(), .bold, 12, .appLight, .orange)
        ButtonReject.makeButtonIcon(named: "xmark.circle")
        ButtonReject.makeHight(height: 40, false, true)
        
        buttonViewProfile.makeItTheme(text: "view_profile".localized(), .bold, 12, .appLight, .appBlue)
        buttonViewProfile.makeHight(height: 40, false, true)
        
        buttonAccept.addTapGestureRecognizer {[weak self] in
            self?.delegate?.acceptAdmission(id: model)
        }
        ButtonReject.addTapGestureRecognizer {[weak self] in
            self?.delegate?.rejectAdmission(id: model)
        }
        buttonViewProfile.addTapGestureRecognizer {[weak self] in
            self?.delegate?.viewProfile(id: model)
        }
        
        labelStatus.text = " \(AMDH.shared.getAdmissionStatus(value: model.AdmissionStatusId ?? 0)) "
        labelStatus.backgroundColor = .appYellow
        
        let admissionStatusId = model.AdmissionStatusId
        buttonAccept.isHidden = true
        ButtonReject.isHidden = true
        buttonViewProfile.isHidden = true
        switch admissionStatusId {
        case 1:
            buttonAccept.isHidden = false
            ButtonReject.isHidden = false
            buttonViewProfile.isHidden = false
        default:
            buttonViewProfile.isHidden = false
        }
        
        //        public enum AdmissionStatus
        //    {
        //        Pending = 1,
        //        Accepted = 2,
        //        Rejected = 3
        //    }
        
        guard let image = URL(string: model.ProfilePictureURL?.convertToHttps() ?? "") else { return }
        iconStudent.contentMode = .scaleAspectFill
        iconStudent.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
    }
    
    func configure(with model: EmployerHomeViewModelData, hideButtons: Bool = false) {
        
        if let jobSeeker = model.jobApplications {
            studentname.text = (jobSeeker.FirstName ?? "Ali Rehman") + " " + (jobSeeker.LastName ?? "")
            disablility.text = "\("disability".localized()): \(jobSeeker.StatusName ?? "")"
            ageNGender.text = "\(jobSeeker.Age ?? 0) years"
            location.text = jobSeeker.Address
            labelStatus.text = " \(AMDH.shared.getAdmissionStatus(value: jobSeeker.StatusId ?? 0)) "
            
            guard let image = URL(string: jobSeeker.profilePicture?.convertToHttps() ?? "") else { return }
            iconStudent.contentMode = .scaleAspectFit
            iconStudent.kf.setImage(with: image,
                                    placeholder: UIImage(named: "studentplacehoder"))
        }
        if let employee = model.employees {
            studentname.text = (employee.Name ?? "")
            disablility.text = "\("disability".localized()): \(employee.DisabilityName ?? "")"
            ageNGender.text = "\(employee.Age ?? 0) years"
            location.text = employee.Address
            labelStatus.text = ""
            labelStatus.isHidden = true
            guard let image = URL(string: employee.ProfilePicture?.convertToHttps() ?? "") else { return }
            iconStudent.contentMode = .scaleAspectFit
            iconStudent.kf.setImage(with: image,
                                    placeholder: UIImage(named: "studentplacehoder"))
        }
        
        labelStatus.backgroundColor = .appYellow
        
        labelStatus.makeItTheme(.bold, 12, .appLight)
        studentname.makeItTheme(.bold, 13, .textDark)
        disablility.makeItTheme(.regular, 12, .appBlue)
        ageNGender.makeItTheme(.regular, 12, .appBlue)
        location.makeItTheme(.regular, 12, .appBlue)
        
        viewBg.applyShadow()
        iconStudent.roundCorner(withRadis: iconStudent.viewWidth.half)
        
        buttonAccept.makeItTheme(text: "accept".localized(), .bold, 14, .appLight, .appGreen)
        buttonAccept.makeButtonIcon(named: "checkmark.circle")
        buttonAccept.makeHight(height: 40, false, true)
        
        ButtonReject.makeItTheme(text: "reject".localized(), .bold, 14, .appLight, .orange)
        ButtonReject.makeButtonIcon(named: "xmark.circle")
        ButtonReject.makeHight(height: 40, false, true)
        
        buttonViewProfile.makeItTheme(text: "view_profile".localized(), .bold, 14, .appLight, .appBlue)
        buttonViewProfile.makeHight(height: 40, false, true)
        
        buttonAccept.isHidden = true
        ButtonReject.isHidden = true
        buttonViewProfile.isHidden = hideButtons
        
        buttonAccept.addTapGestureRecognizer {[weak self] in
            self?.delegateEmployer?.acceptAdmission(id: model.jobApplications?.Id ?? -1)
        }
        ButtonReject.addTapGestureRecognizer {[weak self] in
            self?.delegateEmployer?.rejectAdmission(id: model.jobApplications?.Id ?? -1)
        }
        buttonViewProfile.addTapGestureRecognizer {[weak self] in
            if let jobSeeker = model.jobApplications {
                self?.delegateEmployer?.viewProfile(id: jobSeeker.Id ?? -1)
            }
            if let employee = model.employees {
                self?.delegateEmployer?.viewProfile(id: employee.ID ?? -1)
            }
        }
    }
}


extension Int {
    func makeItGender() -> String {
        if self == 1 {
            return "Male".localized()
        }else if self == 2 {
            return "Female".localized()
        }else {
            return "N/A"
        }
    }
}
