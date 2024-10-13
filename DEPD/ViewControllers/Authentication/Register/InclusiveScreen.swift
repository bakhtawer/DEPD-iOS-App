//
//  InclusiveScreen.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/07/2024.
//

import UIKit
import AVKit
import AVFoundation
import WebKit

class InclusiveScreen: BaseViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var textTopDescription: UILabel!
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var viewPlayer: UIView!
    private var player: AVPlayer!
    private var playerViewController: AVPlayerViewController!
    
    @IBOutlet weak var buttonOne: DEPDButton!
    @IBOutlet weak var buttonTwo: DEPDButton!
    
    var webView: WKWebView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.viewPlayer.frame.width, height: self.viewPlayer.frame.height))

        viewPlayer.backgroundColor = .appDarkBG
        // Add the WKWebView to the view
        self.viewPlayer.addSubview(webView)
//        &ab_channel=DEPDKarachiDEPDKarachi&
        if let url = URL(string: "https://www.youtube.com/embed/R9m-2t0iKEE?playsinline=1&autoplay=1&modestbranding=1&showinfo=0&rel=0&controls=0") {
           let request = URLRequest(url: url)
            webView.load(request)
        }
        
        buttonOne.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionTwo.self)
            view.screenType = .student
            openModuleOnNavigation(from: self, controller: view)
        }
        buttonTwo.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionTwo.self)
            view.screenType = .jobSeeker
            openModuleOnNavigation(from: self, controller: view)
        }

        self.view.backgroundColor = .appBG
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.layoutSubviews()
        view.layoutIfNeeded()
        view.setNeedsDisplay()
        
        // Localise here
        textTopDescription.text = "inclusive_screen_description".localized()
        textTopDescription.makeItTheme(.regular, 11, .textDark, 16.0)
        buttonOne.makeItTheme(text: "register_inclusive_education".localized(),
                              .bold, 24, .appLight, .appGreen)
        buttonTwo.makeItTheme(text: "register_inclusive_career".localized(),
                              .bold, 24, .appLight, .appGreen)
        
        viewBottom.setLanguage()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
