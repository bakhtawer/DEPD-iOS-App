//
//  InstituteStudentCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/09/2024.
//

import UIKit
import Kingfisher

class InstituteStudentCell: UICollectionViewCell {
    
    @IBOutlet weak var iconStudent: UIImageView!
    
    @IBOutlet weak var studentname: UILabel!
    @IBOutlet weak var disablility: UILabel!
    @IBOutlet weak var ageNGender: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var viewProfile: UILabel!
    
    @IBOutlet weak var viewBg: UIView!
    
    static let reuseIdentifier: String = "InstituteStudentCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: InstituteHomeModel) {
        
        studentname.text = (model.student?.FirstName ?? "") + " " + (model.student?.LastName ?? "")
        disablility.text = model.DisabilityName
        ageNGender.text = "\(model.Gender ?? "") | \(model.Gender ?? "")"
        location.text = model.District
        
        viewProfile.makeItTheme(.bold, 13, .appBlue)
        studentname.makeItTheme(.bold, 13, .textDark)
        disablility.makeItTheme(.regular, 12, .appBlue)
        ageNGender.makeItTheme(.regular, 12, .appBlue)
        location.makeItTheme(.regular, 12, .appBlue)
        
        viewBg.applyShadow()
        iconStudent.roundCorner(withRadis: iconStudent.viewWidth.half)
        
        viewProfile.text = "view_profile".localized()
        
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
        
        viewProfile.makeItTheme(.bold, 13, .appBlue)
        studentname.makeItTheme(.bold, 13, .textDark)
        disablility.makeItTheme(.regular, 12, .appBlue)
        ageNGender.makeItTheme(.regular, 12, .appBlue)
        location.makeItTheme(.regular, 12, .appBlue)
        
        viewBg.applyShadow()
        iconStudent.roundCorner(withRadis: iconStudent.viewWidth.half)
        
        viewProfile.text = "view_profile".localized()
        
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
