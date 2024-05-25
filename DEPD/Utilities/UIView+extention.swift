//
//  UIView+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import Foundation
import UIKit

extension UIView {
    
    var viewWidth: CGFloat { return frame.width }
    var viewHeight: CGFloat { return frame.height }
    
    func roundCorner(withRadis: CGFloat) {
        self.layer.cornerRadius = withRadis
        self.layer.masksToBounds = true
    }
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setRoundTopView() {
        self.roundCorners(corners: [.topRight], radius: self.viewWidth.half.half.half)
        self.applyShadow()
    }
    
    func setBorderColor(_ color: UIColor,
                        _ borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    func setRoundBorderColor(_ color: UIColor,
                             _ borderWidth: CGFloat,
                             _ radius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func addTapGesture(tapNumber: Int = 1, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func applyShadow() {
        self.layer.applySketchShadow()
    }
    class func fromNib<T: UIView>() -> T {
        return (Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T)!
    }
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = { _ -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 2.0, completion: @escaping (Bool) -> Void = { _ -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    var hairlineImageView: UIImageView? {
        return hairlineImageView(in: self)
    }

    func hairlineImageView(in view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
            return imageView
        }

        for subview in view.subviews {
            if let imageView = self.hairlineImageView(in: subview) { return imageView }
        }

        return nil
    }
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}
class NormalTextFieldWithShadow: UITextField {
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 8, y: 0, width: 30, height: bounds.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        self.cornerRadius(cornerRadius: 25).backGroundColor(color: .white).shadow()
//        self.font(name: .medium, size: 16).textColor(color: .textBlack).tintColor = .theme
    }
}
extension UITextField {
    func setLeftImage(img: UIImage) {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgView.image = img
        imgView.contentMode = .scaleAspectFit
    }

}

extension UIView {
    @discardableResult func cornerRadius(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        return self
    }
    @discardableResult func backGroundColor(color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    @discardableResult func shadow(color: UIColor = UIColor.black.withAlphaComponent(0.3),
                                   shadowOffset: CGSize = CGSize(width: 1.0, height: 1.0),
                                   shadowOpacity: Float = 0.7) -> Self {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
        return self
    }
    
    
    func addShadow(location: VerticalLocation,
                   color: UIColor = UIColor.black.withAlphaComponent(0.3),
                   opacity: Float = 0.3,
                   radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        }
    }
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
enum VerticalLocation: String {
    case bottom
    case top
}
extension CGFloat {
    var half: CGFloat { return self / 2 }
    var double: CGFloat { return self * 2 }
    
}
