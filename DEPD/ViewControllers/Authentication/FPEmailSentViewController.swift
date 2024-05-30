//
//  FPEmailSentViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

class FPEmailSentViewController: BaseViewController {
    @IBOutlet weak var labelEmailSent: UILabel!
    @IBOutlet weak var buttonOk: UIButton!
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonOk.makeItThemePrimary()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        labelEmailSent.text = "forgot_password_success_message".localized()
        buttonOk.setTitle("forgot_password_success_ok".localized(), for: .normal)
        buttonOk.addTapGestureRecognizer { Bootstrapper.createLogin()}
    }
}
