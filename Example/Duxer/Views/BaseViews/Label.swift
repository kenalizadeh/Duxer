//
//  Label.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

class Label: UILabel {

    var insets: UIEdgeInsets = .zero {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.insets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: self.insets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -self.insets.top, left: -self.insets.left, bottom: -self.insets.bottom, right: -self.insets.right)
        return textRect.inset(by: invertedInsets)
    }
}
