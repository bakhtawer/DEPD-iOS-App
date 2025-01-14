//
//  PlaceholderTextView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/09/2024.
//

import UIKit
class PlaceholderTextView: UITextView {
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.makeItTheme(.regular, 16, .textLightGray)
        return label
    }()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.textContainerInset = UIEdgeInsets(top: 16, left: 14, bottom: 10, right: 16);
        self.textColor = UIColor.textDark
        self.font = UIFont.systemFont(ofSize: 16)
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        // Constraints for placeholder respecting insets
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: textContainerInset.top).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textContainerInset.left + 5).isActive = true
        placeholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -textContainerInset.right).isActive = true

        self.delegate = self
        placeholderLabel.isHidden = !self.text.isEmpty
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.clipsToBounds = true
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderLabel.text {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        placeholderLabel.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

