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
        
        buttonAccept.makeItTheme(text: "accept".localized(), .bold, 14, .appLight, .appGreen)
        buttonAccept.makeButtonIcon(named: "checkmark.circle")
        buttonAccept.makeHight(height: 40, false, true)
        
        ButtonReject.makeItTheme(text: "reject".localized(), .bold, 14, .appLight, .orange)
        ButtonReject.makeButtonIcon(named: "xmark.circle")
        ButtonReject.makeHight(height: 40, false, true)
        
        buttonViewProfile.makeItTheme(text: "view_profile".localized(), .bold, 14, .appLight, .appBlue)
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
    
    func configure(with model: EmployerHomeViewModelData) {
        guard let jobSeeker = model.employees else { return }
        studentname.text = (jobSeeker.jobseeker?.FirstName ?? "Ali Rehman") + " " + (jobSeeker.jobseeker?.LastName ?? "")
        disablility.text = jobSeeker.DisabilityName
        ageNGender.text = "\(jobSeeker.Age ?? "") | \(jobSeeker.Gender?.makeItGender() ?? "")"
        location.text = jobSeeker.District
        
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
        
        let admissionStatusId = 1
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
        
        buttonAccept.addTapGestureRecognizer {[weak self] in
            self?.delegateEmployer?.acceptAdmission(id: model.employees?.jobID ?? -1)
        }
        ButtonReject.addTapGestureRecognizer {[weak self] in
            self?.delegateEmployer?.rejectAdmission(id: model.employees?.jobID ?? -1)
        }
        buttonViewProfile.addTapGestureRecognizer {[weak self] in
            self?.delegateEmployer?.viewProfile(id: model.employees?.jobID ?? -1)
        }
        
        
        guard let image = URL(string: jobSeeker.ProfilePicture?.convertToHttps() ?? "") else { return }
        iconStudent.contentMode = .scaleAspectFit
        iconStudent.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
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
