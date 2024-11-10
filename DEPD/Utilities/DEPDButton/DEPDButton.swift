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
    @IBOutlet weak var buttonRight: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var constraintHightLabel: NSLayoutConstraint!
    
    @IBOutlet weak var paddingTop: NSLayoutConstraint!
    @IBOutlet weak var paddingBotom: NSLayoutConstraint!
    @IBOutlet weak var paddingLeft: NSLayoutConstraint!
    @IBOutlet weak var paddingRight: NSLayoutConstraint!
    
    
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
    
    private var height: CGFloat = 40
    
    func makeHight(height: CGFloat = 40,_ isPadded: Bool = false, _ isNotRounded: Bool = false) {
        self.height = height
        if !isPadded {
            paddingTop.constant = 0
            paddingBotom.constant = 0
            paddingLeft.constant = 0
            paddingRight.constant = 0
        }
        if isNotRounded {
            viewBG.setRoundBorderColor(.clear, 0.0, 0.0)
        }
        refresh()
    }
    
    func makeItTheme(text: String,
                     _ fontType: APPFontType = .bold,
                     _ size: CGFloat = 24,
                     _ color: UIColor = .textDark,
                     _ bgColor: UIColor = .buttonBG,
                     _ contentBgColor: UIColor = .appBG,
                     _ lightHight: CGFloat = 14.0,
                     _ height: CGFloat = 40) {
        labelName.text = text
        labelName.makeItTheme(fontType, size, color, .center, lightHight)
        viewBG.backgroundColor = bgColor
        self.height = height
        contentView.backgroundColor = contentBgColor
        refresh()
    }
    
    func makeButtonIcon(named: String = "play.circle") {
        buttonIcon.image = UIImage(systemName: named)
        buttonIcon.tintColor = .appLight
    }
    
    func makeButtonIconRight(named: String = "square.and.arrow.up") {
        buttonRight.image = UIImage(systemName: named)
        buttonRight.tintColor = .appLight
    }
    
    func makeButtonIconRight(imageNamed: String = "square.and.arrow.up") {
        buttonRight.image = UIImage(named: imageNamed)?.imageWithColor(color1: .appLight)
        buttonRight.tintColor = .appLight
    }
    
    private func refresh() {
        
        // Request a redraw of the view
        setNeedsDisplay()
        // Ensure layout updates are applied immediately if needed
        layoutIfNeeded()
        
        layoutSubviews()
        
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
