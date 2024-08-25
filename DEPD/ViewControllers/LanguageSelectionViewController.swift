//
//  LanguageSelectionViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

class LanguageSelectionViewController: UIViewController {
    
    @IBOutlet weak var labelSelectLangauge: UILabel!
    
    @IBOutlet weak var buttonUrdu: UIButton!
    @IBOutlet weak var buttonEnglish: UIButton!
    @IBOutlet weak var buttonSindhi: UIButton!
    
    var isSelection: Bool = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buttonUrdu.isAccessibilityElement = true
        buttonEnglish.isAccessibilityElement = true
        buttonSindhi.isAccessibilityElement = true
        
        buttonUrdu.makeItThemePrimary()
        buttonEnglish.makeItThemePrimary()
        buttonSindhi.makeItThemePrimary()
        
        labelSelectLangauge.makeItTheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonUrdu.accessibilityLabel = "select ur here".localized()
        buttonEnglish.accessibilityLabel = "select en here".localized()
        buttonSindhi.accessibilityLabel = "select sd here".localized()
        
        labelSelectLangauge.text = "select_language".localized()

        buttonUrdu.addTapGestureRecognizer { [weak self] in
            UserDefaults.set(selectedLanguage: "ur")
            self?.selectLanguage()
        }
        
        buttonEnglish.addTapGestureRecognizer {[weak self] in
            UserDefaults.set(selectedLanguage: "en")
            self?.selectLanguage()
        }
        
        buttonSindhi.addTapGestureRecognizer {[weak self] in
            UserDefaults.set(selectedLanguage: "sd")
            self?.selectLanguage()
        }

    }
    
    func selectLanguage() {
        UserDefaults.standard.set([UserDefaults.selectedLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UIButton.appearance().semanticContentAttribute = .forceRightToLeft
                UITextView.appearance().semanticContentAttribute = .forceRightToLeft
                UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            } else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UIButton.appearance().semanticContentAttribute = .forceLeftToRight
                UITextView.appearance().semanticContentAttribute = .forceLeftToRight
                UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            }
            
            Bootstrapper.createInclusiveScreen()
//            if self.isSelection {
//                self.navigationController?.dismiss(animated: true)
//            }else {   }
        }
    }
}
