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
        
        imageuser.roundCorner(withRadis: imageuser.viewHeight.half)
        imageuser.applyShadow()
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        imageuser.contentMode = .scaleAspectFill
        imageuser.kf.setImage(with: image,
                              placeholder: UIImage(named: "studentplacehoder"))
    }
}
