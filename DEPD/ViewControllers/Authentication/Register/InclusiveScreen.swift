//
//  InclusiveScreen.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/07/2024.
//

import UIKit
import AVKit
import AVFoundation

class InclusiveScreen: BaseViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var textTopDescription: UILabel!
    @IBOutlet weak var buttonInclusiveEducation: UIButton!
    @IBOutlet weak var buttonInclusiveCareer: UIButton!
    
    @IBOutlet weak var viewPlayer: UIView!
    private var player: AVPlayer!
    private var playerViewController: AVPlayerViewController!
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        textTopDescription.makeItTheme(.regular, 10, .textDark, 16.0)
        
        buttonInclusiveEducation.makeItThemeGreenPrimary()
        buttonInclusiveCareer.makeItThemeGreenPrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localise here
        textTopDescription.text = "inclusive_screen_description".localized()
        buttonInclusiveEducation.setTitle("register_inclusive_education".localized(), for: .normal)
        buttonInclusiveCareer.setTitle("register_inclusive_career".localized(), for: .normal)
        
        
        let videoURL = URL(string: "https://www.youtube.com/watch?v=R9m-2t0iKEE&ab_channel=DEPDKarachiDEPDKarachi")
        self.player = AVPlayer(url: videoURL!)
        self.playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        playerViewController.view.frame = CGRect(x: 0, y: 0, width: self.viewPlayer.frame.width, height: self.viewPlayer.frame.height)
        playerViewController.player?.pause()
        self.viewPlayer.addSubview(playerViewController.view)
        
        
        buttonInclusiveEducation.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionTwo.self)
            view.screenType = .student
            openModuleOnNavigation(from: self, controller: view)
        }
        buttonInclusiveCareer.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionTwo.self)
            view.screenType = .job
            openModuleOnNavigation(from: self, controller: view)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
