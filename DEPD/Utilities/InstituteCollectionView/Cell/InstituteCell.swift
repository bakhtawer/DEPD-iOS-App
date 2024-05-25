//
//  InstituteCell.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

class InstituteCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "InstituteCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: InstituteModel) {
        self.backgroundColor = .appBlue
    }

}
