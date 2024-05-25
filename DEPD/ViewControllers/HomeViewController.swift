//
//  HomeViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var buttonInclusiveEducation: UIButton!
    @IBOutlet weak var buttonInclusiveCareer: UIButton!
    
    @IBOutlet weak var viewBanner: BannerView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonInclusiveEducation.makeItThemeLargeWhite(24, .appGreen)
        buttonInclusiveCareer.makeItThemeLargeWhite(24, .appGreen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonInclusiveEducation.addTapGestureRecognizer {
        }
        buttonInclusiveCareer.addTapGestureRecognizer {
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
        
        
        DispatchQueue.main.async {[weak self] in
            let banners = [BannerModel(),BannerModel(),BannerModel(),BannerModel(),BannerModel(),BannerModel()]
            self?.viewBanner.populate(banners: banners)
        }
    }
}
extension HomeViewController {
    
    func setupNavigation() {
        self.setLogo()
        self.setNavBarColor(.appBlue)
//        self.setLeftMenuBtn(.white).addTarget(self, action: #selector(actionMenu(_:)), for: .touchUpInside)
    }
}
