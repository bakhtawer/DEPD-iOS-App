//
//  BannerCCell.swift
//  Points
//
//  Created by Shahzaib Iqbal Bhatti on 6/23/21.
//

import UIKit

class BannerCCell: UICollectionViewCell, SelfDealsConfiguringCell {
    
    static let reuseIdentifier: String = "BannerCCell"

    @IBOutlet weak var imageBannenr: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imageBannenr.setSkeletonView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageBannenr.roundCorner(withRadis: 10)
    }
    func configure(with deals: BannerModel) {
        let colors = [UIColor.blue, .red, .black, .purple, .cyan]
        imageBannenr.backGroundColor(color: colors.randomElement() ?? .blue)
        
//        if deals.imagePath?.isEmpty ?? true {
//            imageBannenr.showHideSkeletonView(show: true)
//        }else {
//            imageBannenr.showHideSkeletonView(show: false)
//        }
//        
//        guard let image = deals.imagePath  else { return }
//        ImageManager().setImage(url: image, imageView: imageBannenr)
    }
}
