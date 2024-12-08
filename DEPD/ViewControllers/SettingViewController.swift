//
//  SettingViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 07/07/2024.
//

import UIKit

class SettingViewController: BaseViewController {
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var labeluser: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var buttonLogout: UIButton!
    
    @IBOutlet weak var labelVersion: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonLogout.makeItThemePrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labeluser.text = USM.shared.getUserFullName()
        
        buttonLogout.setTitle("logout".localized(), for: .normal)
        
        
        buttonLogout.addTapGestureRecognizer {
            UserSessionManager.shared.LogoutUser()
            Bootstrapper.createSplash()
        }
        
        
        labelVersion.text = Bundle.main.releaseVersionNumberPretty
        labelVersion.makeItTheme(.bold, 12, .textLightGray)
        
        imageuser.roundCorner(withRadis: imageuser.viewHeight.half)
        imageuser.applyShadow()
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        imageuser.contentMode = .scaleAspectFill
        imageuser.kf.setImage(with: image,
                              placeholder: UIImage(named: "studentplacehoder"))
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0").\(buildVersionNumber ?? "")"
    }
}
