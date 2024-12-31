//
//  InstituteCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit
import Kingfisher

class InstituteCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "InstituteCell"
    
    @IBOutlet weak var btnViewInfo: UIButton!
    
    @IBOutlet weak var labelDistrict: UILabel!
    @IBOutlet weak var labelSeats: UILabel!
    
    @IBOutlet weak var imageSchool: UIImageView!
    
    @IBOutlet weak var viewMainBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBOutlet weak var viewBottomLine: UIView!
    
    
    @IBOutlet weak var viewPaid: UIView!
    @IBOutlet weak var labelpaidFree: UILabel!
    
    func configure(with model: InstituteModel) {
        
        btnViewInfo.makeItThemePrimary(14)
        btnViewInfo.setTitle("view_info".localized(), for: .normal)
        btnViewInfo.isUserInteractionEnabled = false
        
        viewMainBg.layer.cornerRadius = 6.0
        viewMainBg.applyShadow()
        
        labelDistrict.text = model.SchoolName
        labelSeats.text = "\(model.NumberOfSeats ?? 0) seats available"
        
        labelDistrict.makeItTheme(.bold, 14, .appBlue)
        labelSeats.makeItTheme(.medium, 10, .textDark)
        
        viewPaid.roundCorner(withRadis: viewPaid.viewHeight.half)
        labelpaidFree.makeItTheme(.medium, 10, .textLight)
        
        //        FreeOrPaid = {1,2}
        //
        //        1.⁠ ⁠Free
        //        2.⁠ ⁠Paid
        switch model.FreeOrPaid {
        case 2: labelpaidFree.text = "Paid".localized()
        case 1: labelpaidFree.text = "Free".localized()
        default:
            viewPaid.isHidden = true
        }

        guard let image = URL(string: model.ImageURL?.convertToHttps() ?? "") else { return }
        imageSchool.contentMode = .scaleAspectFill
        imageSchool.kf.setImage(with: image)
    }
}
