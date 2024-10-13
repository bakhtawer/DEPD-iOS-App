//
//  ThankYouViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

class ThankYouViewController: BaseViewController {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imageThankyou: UIImageView!
    @IBOutlet weak var labelThankYouMessage: UILabel!
    
    enum MessageThankYou {
        case none
        case registeredSuccess
        case yourSchoolHasBeen(_ school: String)
        case updateSchoolInfo
        var value: String {
            switch self {
            case .none: return ""
            case .registeredSuccess: return "register_success_message".localized()
            case .yourSchoolHasBeen(let school): return "Your Application has been submitted to \(school) school"
            case .updateSchoolInfo: return "\("school_information".localized()) Updated"
            }
        }
    }
    
    enum MoveThankYou {
        case home
        case stay
    }
    
    var messageThankYou: MessageThankYou = .none
    var moveThankYou: MoveThankYou = .home
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBG.roundCorner(withRadis: 8)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelThankYouMessage.text = messageThankYou.value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {[weak self] in
            self?.canGoForword()
        })
    }
    
    func canGoForword() {
        DispatchQueue.main.async {[weak self] in
            switch self?.moveThankYou {
            case .home: Bootstrapper.createHome()
            case .stay: self?.dismiss(animated: true)
            case .none: break
            }
        }
    }
}
