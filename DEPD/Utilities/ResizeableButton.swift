//
//  ResizeableButton.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/08/2024.
//

import UIKit

class ResizableButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        // Adjust the size of the button based on the text size
        if let titleLabel = self.titleLabel {
            titleLabel.sizeToFit() // Ensure the label fits the text
            let padding: CGFloat = 10 // Add padding around the text
            self.frame.size = CGSize(width: titleLabel.frame.width + padding * 2, height: titleLabel.frame.height + padding * 2)
        }
    }
}
