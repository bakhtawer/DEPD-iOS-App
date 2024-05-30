//
//  BottomView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

class BottomView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var viewAccessibility: UIView!
    @IBOutlet weak var labelAccessibility: UILabel!
    
    @IBOutlet weak var viewhelp: UIView!
    @IBOutlet weak var labelHelp: UILabel!
    
    @IBOutlet weak var viewLangauge: UIView!
    @IBOutlet weak var labelLanguage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit BannerView")
    }
    
    func setLanguage() {
        labelAccessibility.text = "accessibility".localized()
        labelHelp.text = "help".localized()
        labelLanguage.text = "langauge".localized()
    }
    
    private func setUpView() {
        Bundle.main.loadNibNamed("BottomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setLanguage()
        
        viewAccessibility.addTapGestureRecognizer {
            SMM.shared.showStatusInfo(message: "view Accessibility")
        }
        
        viewhelp.addTapGestureRecognizer {
            SMM.shared.showStatusInfo(message: "view Help")
        }
        
        viewLangauge.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: LanguageSelectionViewController.self)
            view.isSelection = true
            openModuleOnFullScreen(controller: view)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
