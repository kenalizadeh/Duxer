//
//  Button+ConfigurableView.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit
import WrapperCell

extension Button: ConfigurableView {

    struct Item {
        let image: UIImage?
        let text: TextContent
        let tintColor: UIColor?
    }

    func configure(_ item: Item) {
        self.setImage(item.image, for: [])
        self.setAttributedTitle(NSAttributedString(from: item.text), for: [])
        self.tintColor = item.tintColor
        self.isUserInteractionEnabled = false
    }

    func reset() {
        self.setImage(nil, for: [])
        self.setAttributedTitle(nil, for: [])
        self.isUserInteractionEnabled = true
        self.tintColor = nil
    }
}

typealias ButtonCell = WrapperCell<Button>
