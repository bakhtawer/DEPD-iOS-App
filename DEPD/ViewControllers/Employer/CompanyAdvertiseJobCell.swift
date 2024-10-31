//
//  CompanyAdvertiseJobCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 13/10/2024.
//

import UIKit
import Kingfisher

class CompanyAdvertiseJobCell: UICollectionViewCell {
    
    @IBOutlet weak var iconAd: UIImageView!
    
    static let reuseIdentifier: String = "CompanyAdvertiseJobCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: EmployerHomeViewModelData) {
        guard let company = model.company else { return }
        
        guard let image = URL(string: company.CompanyImageURL?.convertToHttps() ?? "") else { return }
        iconAd.contentMode = .scaleAspectFill
        iconAd.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
    }
}

