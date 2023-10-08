//
//  NSAttributedString+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
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
