//
//  BaseViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit
import NVActivityIndicatorView

enum ViewTags: Int {
    case bgViewTag = 1001
    case activityViewTag = 1002
    case popupView = 1003
}

class BaseViewController: UIViewController {
    
    let viewBGLoder: UIView = UIView()
    var activityView: NVActivityIndicatorView!
    
    let bgViewTag = ViewTags.bgViewTag.rawValue
    let activityViewTag = ViewTags.activityViewTag.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func addDimView() {
        self.viewBGLoder.frame = UIScreen.main.bounds
        self.viewBGLoder.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.viewBGLoder.tag = bgViewTag
        UIApplication.shared.keyWindow?.addSubview(self.viewBGLoder)
    }
    
    func showLoadingIndicator(withDimView: Bool = false) {
        if activityView == nil {
            
            let originX = UIScreen.main.bounds.width/2
            let originY = UIScreen.main.bounds.height/2
            let frame = CGRect(x: originX - 50.0/2,
                               y: originY - 50.0/2,
                               width: 50.0,
                               height: 50.0)
           
            activityView = NVActivityIndicatorView(frame: frame,
                                                   type: .ballSpinFadeLoader,
                                                   color: .appGreen,
                                                   padding: 0.0)
            activityView.tag = activityViewTag
            
            // add subview
            withDimView ? self.addDimView() : ()
            UIViewController.top().view.addSubview(self.activityView)
            DispatchQueue.main.async {[weak self] in
                self?.activityView.startAnimating()
            }
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {[weak self] in
            if self?.activityView != nil {
                self?.viewBGLoder.removeFromSuperview()
                //UIApplication.shared.endIgnoringInteractionEvents()
                self?.activityView.stopAnimating()
                self?.activityView = nil
                
                UIApplication.shared.keyWindow?.viewWithTag(ViewTags.bgViewTag.rawValue)?.removeFromSuperview()
                UIApplication.shared.keyWindow?.viewWithTag(ViewTags.activityViewTag.rawValue)?.removeFromSuperview()
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

 extension BaseViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
//            FLEXManager.shared.showExplorer()
        }
    }
 }

extension UIViewController {

    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left,
                                             bottom: keyboardSize.height, right: scrollView.contentInset.right)
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }

    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
}

extension BaseViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


protocol MVVMViewControllerProtocol: AnyObject {
    associatedtype T
    
    init(coder aDecoder: NSCoder, viewModel: T)
    init(viewModel: T)
}

class MVVMViewController<U>: BaseViewController, MVVMViewControllerProtocol {
    
    typealias T = U
    let viewModel: T
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(coder aDecoder: NSCoder, viewModel: T) {
        self.viewModel = viewModel
        super.init(coder: aDecoder)!
    }
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
}
