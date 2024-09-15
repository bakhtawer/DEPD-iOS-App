//
//  DEPDButton.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/08/2024.
//
import UIKit

@IBDesignable
class DEPDButton: UIView {
    
    @IBOutlet weak var buttonIcon: UIImageView!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var constraintHightLabel: NSLayoutConstraint!
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
    
    
    func makeItTheme(text: String,
                     _ fontType: APPFontType = .bold,
                     _ size: CGFloat = 24,
                     _ color: UIColor = .textDark,
                     _ bgColor: UIColor = .buttonBG,
                     _ lightHight: CGFloat = 14.0) {
        labelName.text = text
        labelName.makeItTheme(fontType, size, color, lightHight)
        viewBG.backgroundColor = bgColor
        refresh()
    }
    
    func makeButtonIcon(named: String = "play.circle") {
        buttonIcon.image = UIImage(systemName: named)
        buttonIcon.tintColor = .appLight
    }
    
    private func refresh() {
        
        // Request a redraw of the view
        setNeedsDisplay()
        // Ensure layout updates are applied immediately if needed
        layoutIfNeeded()
        
        layoutSubviews()
        
        var height: CGFloat = 40
        
        switch UserDefaults.selectedAccessibility {
        case 1: height = height*1.2
        case 2: height = height*1.5
        case 3: height = height*1.6
        default: break
        }
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            height = height * 1.5
        }
        
        self.constraintHightLabel.constant = height
    }
    
    private func setUpView() {
        Bundle.main.loadNibNamed("DEPDButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = .appBG

        viewBG.setRoundBorderColor(.clear, 0.0, 6.0)
        viewBG.applyShadow()
        
        refresh()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
