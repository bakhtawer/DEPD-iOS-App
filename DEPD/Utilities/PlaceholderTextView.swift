//
//  PlaceholderTextView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/09/2024.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    // Placeholder Label
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // Initializer
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        // Set default text color
        self.textColor = UIColor.lightGray
        self.font = UIFont.systemFont(ofSize: 16)
        
        // Add placeholder label to UITextView
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for placeholder label
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
               
        
        // Set delegate to handle text changes
        self.delegate = self
        
        // Show placeholder initially if no text
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false
        self.layer.applySketchShadow()
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    
    // When the user starts editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Remove the placeholder and change text color
        if textView.text == "Message" {
            textView.text = ""
            textView.textColor = UIColor.textDark
        }
        placeholderLabel.isHidden = true
    }
    
    // When the user finishes editing
    func textViewDidEndEditing(_ textView: UITextView) {
        // Show placeholder if the text view is empty
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
            placeholderLabel.isHidden = false
        }
    }
    
    // Hide placeholder while typing
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
