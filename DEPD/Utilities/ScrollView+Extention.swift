//
//  ScrollView+Extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

extension UIScrollView {

    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
    
    func scrollToTop() {
            let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
            setContentOffset(desiredOffset, animated: true)
    }
    
    // Pull to refresh
    func addRefreshControl(action: (() -> Void)?) {
        let refreshControl = RefreshControl()
        refreshControl.tintColor = .appGreen
        refreshControl.addAction(for: .valueChanged) {
            if let refreshAction = action {
                refreshAction()
            }
        }
        refreshControl.backgroundColor = .white
        self.addSubview(refreshControl)
    }
    func addRefreshControlWhite(action: (() -> Void)?) {
        let refreshControl = RefreshControl()
        refreshControl.tintColor = .appGreen
        refreshControl.addAction(for: .valueChanged) {
            if let refreshAction = action {
                refreshAction()
            }
        }
        refreshControl.backgroundColor = .appLight
        self.addSubview(refreshControl)
    }
    
    func endRefreshing() {
        for view in self.subviews {
            if let refreshControl = view as? UIRefreshControl {
                refreshControl.endRefreshing()
                break
            }
        }
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}

//------------------------------------------------------

// MARK: - Uicontol + Action class

var AssociatedObjectHandle: UInt8 = 0

class ClosureSleeve {
    let closure: () -> Void
    
    init(attachTo: AnyObject, closure: @escaping () -> Void) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, &AssociatedObjectHandle, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc func invoke() {
        closure()
    }
}
class RefreshControl: UIRefreshControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let originalFrame = frame
        frame = originalFrame
    }
    
    override var isHidden: Bool {
        get {
            return super.isHidden
        }
        set(hiding) {
            if hiding {
                guard frame.origin.y >= 0 else { return }
                super.isHidden = hiding
            } else {
                guard frame.origin.y < 0 else { return }
                super.isHidden = hiding
            }
        }
    }
    override var frame: CGRect {
        didSet {
            if frame.origin.y < 0 {
                isHidden = false
            } else {
                isHidden = true
            }
        }
    }
}
