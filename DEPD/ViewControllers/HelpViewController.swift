//
//  HelpViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/09/2024.
//

import UIKit

class HelpViewController: BaseViewController {
    @IBOutlet weak var buttonComplain: DEPDButton!
    @IBOutlet weak var buttonSuggestions: DEPDButton!
    
    @IBOutlet weak var viewTextBG: UIView!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelDetials: UILabel!
    
    @IBOutlet weak var ButtonWatchVideo: DEPDButton!
    @IBOutlet weak var buttonReadYourLegal: DEPDButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.layoutSubviews()
        view.layoutIfNeeded()
        view.setNeedsDisplay()
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        buttonComplain.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: GenericFormBuilderViewController.self)
            view.screenType = .complain
            openModuleOnNavigation(from: self, controller: view)
        }
        
        buttonSuggestions.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: GenericFormBuilderViewController.self)
            view.screenType = .suggestions
            openModuleOnNavigation(from: self, controller: view)
        }
        
        ButtonWatchVideo.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: WatchVideoViewController.self)
            openModuleOnNavigation(from: self, controller: view)
        }
        
        buttonReadYourLegal.addTapGestureRecognizer {
            SMM.shared.showStatusInfo(message: "Coming Soon")
        }
    }
    
    private func setView() {
        labelTop.makeItTheme(.bold, 20, .appLight)
        labelDetials.makeItTheme(.regular, 14, .appLight)
        
        viewTextBG.layer.cornerRadius = 6
        viewTextBG.applyShadow()
        
        buttonComplain.makeItTheme(text: "help_complain".localized(),
                              .bold, 18, .appLight)
        buttonSuggestions.makeItTheme(text: "help_suggestions".localized(),
                              .bold, 18, .appLight)
        ButtonWatchVideo.makeItTheme(text: "help_watch_videos".localized(),
                              .bold, 14, .appLight)
        buttonReadYourLegal.makeItTheme(text: "help_legal_rights".localized(),
                              .bold, 12, .appLight)
        
        ButtonWatchVideo.makeButtonIcon(named: "play.circle")
    }
}

extension HelpViewController {
    func setupNavigation() {
        self.setLogo()
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.appDarkBG).addTapGestureRecognizer {[weak self] in
            self?.dismiss(animated: true)
        }
    }
}
