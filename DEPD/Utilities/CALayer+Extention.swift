//
//  CALayer+Extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit
extension CALayer {
    
    func applySketchShadow( color: UIColor = .black, alpha: Float = 0.4,
                            xoff: CGFloat = 0, yoff: CGFloat = 2,
                            blur: CGFloat = 10, spread: CGFloat = 0) {
        
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xoff, height: yoff)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dxpos = -spread
            let rect = bounds.insetBy(dx: dxpos, dy: dxpos)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
