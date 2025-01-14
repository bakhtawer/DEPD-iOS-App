//
//  MyApplicationsCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 31/12/2024.
//

import UIKit

class MyApplicationsCell: UICollectionViewCell {
    
    @IBOutlet weak var titleSchoolName: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    
    @IBOutlet weak var titleClass: UILabel!
    @IBOutlet weak var labelClass: UILabel!
    
    @IBOutlet weak var titleApplicationDate: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var titleStatus: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    
    @IBOutlet weak var viewBg: UIView!
    
    static let reuseIdentifier: String = "MyApplicationsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: MyApplicationsModel) {
        titleSchoolName.makeItTheme(.bold, 14, .appBlue)
        schoolName.makeItTheme(.bold, 14, .appBlue)
        titleClass.makeItTheme(.bold, 12, .textDark)
        labelClass.makeItTheme(.bold, 12, .textDark)
        titleApplicationDate.makeItTheme(.bold, 12, .textDark)
        labelDate.makeItTheme(.bold, 12, .textDark)
        titleStatus.makeItTheme(.bold, 12, .textDark)
        labelStatus.makeItTheme(.bold, 12, .textLight)
        labelStatus.backgroundColor = .appYellow
        
        titleSchoolName.text = "\("school_name".localized()):"
        titleClass.text = "\("class".localized()):"
        titleApplicationDate.text = "\("applications_date".localized()):"
        titleStatus.text = "\("status".localized()):"
        
        schoolName.text = model.SchoolName
        labelClass.text = model.ClassName
        labelDate.text = model.AppliedOnDate
        labelStatus.text = " \(model.AdmissionStatus ?? "") "
    }
}

