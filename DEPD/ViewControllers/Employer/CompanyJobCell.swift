//
//  CompanyJobCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 13/10/2024.
//

import UIKit
import Kingfisher

class CompanyJobCell: UICollectionViewCell {
    
    @IBOutlet weak var iconStudent: UIImageView!
    
    @IBOutlet weak var studentname: UILabel!
    @IBOutlet weak var disablility: UILabel!
    @IBOutlet weak var ageNGender: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var viewProfile: UILabel!
    
    @IBOutlet weak var viewBg: UIView!
    
    static let reuseIdentifier: String = "CompanyJobCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: EmployerHomeViewModelData) {
        guard let company = model.company else { return }
        studentname.text = (company.CompanyName ?? "")
        disablility.text = company.PositionName
        ageNGender.text = company.Salary
        location.text = company.Location
        
        viewProfile.makeItTheme(.bold, 13, .appBlue)
        studentname.makeItTheme(.bold, 13, .textDark)
        disablility.makeItTheme(.regular, 12, .appBlue)
        ageNGender.makeItTheme(.regular, 12, .appBlue)
        location.makeItTheme(.regular, 12, .appBlue)
        
        viewBg.applyShadow()
        iconStudent.roundCorner(withRadis: iconStudent.viewWidth.half)
        
        viewProfile.text = "view_profile".localized()
        
        guard let image = URL(string: company.CompanyImageURL?.convertToHttps() ?? "") else { return }
        iconStudent.contentMode = .scaleAspectFill
        iconStudent.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
    }
}

