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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: InstituteModel) {
        
        btnViewInfo.makeItThemePrimary(13)
        btnViewInfo.setTitle("view_info".localized(), for: .normal)
        
        labelDistrict.text = model.Location
        labelSeats.text = "\(model.NumberOfSeats ?? 0) seats available"
        
        labelDistrict.makeItTheme(.medium, 12, .appBlue)
        labelSeats.makeItTheme(.light, 8, .textDark)
        
        guard let image = URL(string: model.ImageURL ?? "") else { return }
        imageSchool.kf.setImage(with: image)
    }
}
