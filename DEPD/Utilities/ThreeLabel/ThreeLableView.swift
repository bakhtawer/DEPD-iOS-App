//
//  ThreeLableView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/11/2024.
//

import UIKit

@IBDesignable
class ThreeLableView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var ImageTrash: UIImageView!
    
    @IBOutlet weak var viewLine: UIView!
    
    
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
    
    private func setUpView() {
        Bundle.main.loadNibNamed("ThreeLableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func populateWith(index: Int, id: Int, stringOne:String?, stringTwo: String? = nil, stringThree: String? = nil) {
        labelOne.text = stringOne
        labelTwo.text = stringTwo
        labelThree.text = stringThree
        
        labelOne.makeItTheme(.bold, 14, .textDark)
        labelTwo.makeItTheme(.regular, 12, .textDark)
        labelThree.makeItTheme(.regular, 12, .textDark)
        
        ImageTrash.addTapGestureRecognizer {[weak self] in
            self?.onDeleteToggle?(index)
        }
    }
    
    // Closure to notify about changes
    var onDeleteToggle: ((Int) -> Void)?
}
