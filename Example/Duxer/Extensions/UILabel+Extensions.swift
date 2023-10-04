//
//  UILabel+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 22.04.23.
//

import UIKit

extension UILabel {

    func setText(content: TextContent?, formatter: StringFormatter? = nil) {

        guard var content
        else {
            self.resetTextContent()
            return
        }

        if let formatter {
            content.string = formatter.encoded(text: content.string)
        }

        self.text = content.string
        self.textColor = content.color
        self.font = content.font
    }

    func setAttributedText(content: TextContent?, formatter: StringFormatter? = nil) {

        guard var content
        else {
            self.resetTextContent()
            return
        }

        if let formatter {
            content.string = formatter.encoded(text: content.string)
        }

        self.attributedText = NSAttributedString(from: content)
    }

    func resetTextContent() {
        self.text = nil
        self.textColor = nil
        self.font = nil
    }
}
