//
//  AccessibilityViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 25/08/2024.
//

import UIKit

class AccessibilityViewController: BaseViewController {
    
    @IBOutlet weak var viewBiggerText: UIView!
    @IBOutlet weak var labelBiggertext: UILabel!
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    
    var selectedBtState: BtState = .off
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        
        selectedBtState = BtState(rawValue: UserDefaults.selectedAccessibility) ?? .off
        
        viewBiggerText.addTapGestureRecognizer {[weak self] in
            var stateValue = (self?.selectedBtState.rawValue ?? 3) + 1
            if stateValue == 4 {stateValue = 0}
            self?.selectedBtState = BtState(rawValue: stateValue) ?? .off
            UserDefaults.set(selectedAccessibility: stateValue)
            self?.setButtons()
        }
        setButtons()
        viewOne.clipsToBounds = true
        viewTwo.clipsToBounds = true
        viewThree.clipsToBounds = true
    }
    enum BtState: Int {
        case off = 0
        case one
        case two
        case three
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBiggerText.layer.cornerRadius = 6
        viewBiggerText.applyShadow()
        viewOne.roundCorner(withRadis: 2)
        viewTwo.roundCorner(withRadis: 2)
        viewThree.roundCorner(withRadis: 2)
    }
    
    private func setButtons() {
        
        viewOne.isHidden = false
        viewTwo.isHidden = false
        viewThree.isHidden = false
        
        labelBiggertext.makeItTheme(.regular, 12)
        
        switch selectedBtState {
        case .off:
            viewBiggerText.setBorderColor(.appLight, 1)
            viewOne.isHidden = true
            viewTwo.isHidden = true
            viewThree.isHidden = true
        case .one:
            viewBiggerText.setBorderColor(.appGreen, 1)
            viewOne.alpha = 1.0
            viewTwo.alpha = 0.3
            viewThree.alpha = 0.3
        case .two:
            viewBiggerText.setBorderColor(.appGreen, 1)
            viewOne.alpha = 1.0
            viewTwo.alpha = 1.0
            viewThree.alpha = 0.3
        case .three:
            viewBiggerText.setBorderColor(.appGreen, 1)
            viewOne.alpha = 1.0
            viewTwo.alpha = 1.0
            viewThree.alpha = 1.0
        }
    }
}
extension AccessibilityViewController {
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.appBlue).addTapGestureRecognizer {[weak self] in
            self?.dismiss(animated: true)
        }
    }
}
