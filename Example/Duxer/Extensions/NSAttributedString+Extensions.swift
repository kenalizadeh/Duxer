//
//  NSAttributedString+Extensions.swift
//  DuxerExample
//
//  Created by 004230 on 22.04.23.
//

import Foundation

extension NSAttributedString {

    convenience init(from content: TextContent) {

        self.init(
            string: content.string,
            attributes: [
                .font: content.font,
                .foregroundColor: content.color
            ]
        )
    }
}
