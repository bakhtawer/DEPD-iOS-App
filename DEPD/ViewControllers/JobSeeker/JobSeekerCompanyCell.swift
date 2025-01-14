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
        
        guard let image = URL(string: model.ThumbnailImageURL?.convertToHttps() ?? "") else { return }
        imageCompany.contentMode = .scaleAspectFill
        imageCompany.kf.setImage(with: image)
    }
    
    func configure(with model: EmployerHomeViewModelData) {
        viewBg.applyShadow()
        
        companayPosting.makeItTheme(.bold, 16, .textDark)
        companayname.makeItTheme(.regular, 14, .textLightGray)
        companayJobsCoun.makeItTheme(.regular, 14, .textLightGray)
        
        companayPosting.text = model.advertise?.Position
        companayname.text = model.advertise?.CompanyName
        companayJobsCoun.text = "\(model.advertise?.NumOfVaccancies ?? "0") \("jobs".localized())"
        
        guard let image = URL(string: model.advertise?.ThumbnailImageURL?.convertToHttps() ?? "") else { return }
        imageCompany.contentMode = .scaleAspectFill
        imageCompany.kf.setImage(with: image)
    }
}
