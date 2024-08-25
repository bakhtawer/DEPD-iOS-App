//
//  UIViewController+Extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

extension UIViewController {
    
    static func top() -> UIViewController {
        
        let keyWindow = UIApplication.shared.keyWindow

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        fatalError("No view controller present in app?")
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func close() {
        if self.navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension UIViewController {
    
    func removeTitle() {
        self.title = nil
    }
    
    func setTitle(_ title: String, 
                  _ color: UIColor = .textDark) {
        self.title = title
        
        let titleFont = UIFont.boldSystemFont(ofSize: 18)
        
        let attributes = [NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font: titleFont]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
    }
    
    func navBarPreset() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setNavBarColor(_ color: UIColor) {
        //Unwrap navigationController
        guard let navigationController = self.navigationController else { return }
        // To change background colour.
        navigationController.navigationBar.barTintColor = color
        // To change colour of tappable items.
        navigationController.navigationBar.tintColor = color
        // To control navigation bar's translucency.
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = color
        
        UINavigationBar.appearance().barTintColor = color
        navigationController.navigationBar.barTintColor = color
        navigationController.navigationBar.isTranslucent = false
        
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    func setBackButton(_ tint: UIColor = .clear) -> UIButton {
        let buttonMenu: UIButton = UIButton.init(type: .custom)
        var image = UIImage(named: "backBtn")?.withRenderingMode(.alwaysTemplate)
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            image = image?.flipHorizontally()?.withRenderingMode(.alwaysTemplate)
            buttonMenu.contentHorizontalAlignment = .right
        }else {
            buttonMenu.contentHorizontalAlignment = .left
        }
        
        buttonMenu.setImage(image,
                            for: UIControl.State.normal)
        buttonMenu.setImage(image,
                            for: UIControl.State.highlighted)
        buttonMenu.setImage(image,
                            for: UIControl.State.selected)
        buttonMenu.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        buttonMenu.tintColor = tint
        let buttonBackBar = UIBarButtonItem(customView: buttonMenu)
        self.navigationItem.leftBarButtonItem = buttonBackBar
        return buttonMenu
    }
    
    func setNavigationTransparent(_ title: String = "") {
        self.setLogo()
        self.setNavBarColor(.white)
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        //        self.navigationController?.navigationBar.layer.shadowColor = .appDark
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 1
        
        //        if self.navigationController != nil {
        //
        //            if let navigationBar = self.navigationController?.navigationBar {
        //                let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width*0.8, height: navigationBar.frame.height)
        //                let firstLabel = UILabel(frame: firstFrame)
        //                firstLabel.center = navigationBar.center
        //                firstLabel.text = title
        //                firstLabel.font = UIFont(name: THEMEFONTS.BalooThambi2ExtraBold.rawValue, size: 18) ?? UIFont.boldSystemFont(ofSize: 16)
        //                firstLabel.textColor = .themeYellow
        //                firstLabel.numberOfLines = 0
        //                firstLabel.adjustsFontSizeToFitWidth = true
        //                firstLabel.minimumScaleFactor = 0.2
        //
        //                firstLabel.textAlignment = .center
        //                firstLabel.clipsToBounds = true
        ////                navigationBar.addSubview(firstLabel)
        //            }
        //
        //            self.navigationController?.navigationBar.setBackgroundImage(UIColor.themeBorderColor.as1ptImage(), for: .default)
        //            self.navigationController?.navigationBar.shadowImage = UIColor.themeBorderColor.as1ptImage()
        //            self.navigationController?.navigationBar.isTranslucent = true
        //            self.navigationController?.navigationBar.backgroundColor = .white
        //            self.navigationController?.navigationBar.barTintColor = .clear
        //
        ////            self.navigationController?.navigationBar.shadowImage = UIColor.themeBorderColor.as1ptImage()
        //
        //            self.navigationController?.navigationBar.layer.masksToBounds = false
        //            self.navigationController?.navigationBar.layer.shadowColor = UIColor.themeBorderColor.cgColor
        //            self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        //            self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        //            self.navigationController?.navigationBar.layer.shadowRadius = 1
        //
        //
        //            self.setNavBarColor(.white)
        //        }
    }
    
    @discardableResult func setLeftBackBtn(_ tint: UIColor = .appBG) -> UIButton {
        let button = UIButton(type: .custom)
        let backBtnImage = UIImage(named: "iconBackBtn")?.withRenderingMode(.alwaysOriginal).imageWithColor(color1: tint)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        button.setImage(backBtnImage, for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        barButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        barButton.width = -0
        self.navigationItem.leftBarButtonItem = barButton
        return button
    }
    @discardableResult func setLeftMenuBtn(_ tint: UIColor = .appBG) -> UIButton {
        let button = UIButton(type: .custom)
        let backBtnImage = UIImage(named: "icon_main_menu")?.withRenderingMode(.alwaysOriginal).imageWithColor(color1: tint)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        //        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.setImage(backBtnImage, for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        barButton.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.navigationItem.leftBarButtonItem = barButton
        barButton.width = -20
        return button
    }
    @discardableResult func setRightMenuBtn(_ tint: UIColor = .clear) -> UIButton {
        let button = UIButton(type: .custom)
        //        if lastServerSucessMessageUnreadCout ?? 0 > 0 {
        //            isFull = true
        //        }
        let name = "icon_noti_selected"
        let backBtnImage = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 25)
        button.setImage(backBtnImage, for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        barButton.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.navigationItem.rightBarButtonItem = barButton
        barButton.width = -20
        return button
    }
    func setLogo(_ tint: UIColor = .clear) {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 10, width: 135, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 135, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "icon_nav_dark")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }
    
    @discardableResult func setRightCartBtn(_ isFull: Bool = false,
                                            _ tint: UIColor = .clear) -> UIButton {
        let button = UIButton(type: .custom)
        let name = isFull ? "icon_cart_full" : "icon_cart_empty"
        let backBtnImage = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        button.setImage(backBtnImage, for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        barButton.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.navigationItem.rightBarButtonItem = barButton
        barButton.width = -20
        return button
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        let tag = 3848245
        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first
        
        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999
            
            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }
    }
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
