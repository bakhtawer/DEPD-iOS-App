//
//  JobSeekerCompanyCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/10/2024.
//

import UIKit

import UIKit
import Kingfisher

class JobSeekerCompanyCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCompany: UIImageView!
    @IBOutlet weak var companayPosting: UILabel!
    @IBOutlet weak var companayname: UILabel!
    @IBOutlet weak var companayJobsCoun: UILabel!
    @IBOutlet weak var viewBg: UIView!
    
    static let reuseIdentifier: String = "JobSeekerCompanyCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: CompanyModel) {
        
        viewBg.applyShadow()
        
        companayPosting.makeItTheme(.bold, 16, .textDark)
        companayname.makeItTheme(.regular, 14, .textLightGray)
        companayJobsCoun.makeItTheme(.regular, 14, .textLightGray)
        
        companayPosting.text = model.PositionName
        companayname.text = model.CompanyName
        companayJobsCoun.text = "\(model.NoOfVaccancies ?? 0) \("jobs".localized())"
        
        guard let image = URL(string: model.CompanyImageURL?.convertToHttps() ?? "") else { return }
        imageCompany.contentMode = .scaleAspectFit
        imageCompany.kf.setImage(with: image)
    }
    
}
