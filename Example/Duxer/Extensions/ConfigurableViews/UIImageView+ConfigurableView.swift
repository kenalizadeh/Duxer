//
//  UIImageView+ConfigurableView.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

extension UIImageView: ConfigurableView {

    public struct Item {
        let contentMode: UIControl.ContentMode
        let image: Image
        let tintColor: UIColor?
    }

    public func configure(_ item: Item) {
        self.contentMode = item.contentMode
        self.image = item.image.uiImage
        self.tintColor = item.tintColor
    }

    public func reset() {
        self.contentMode = .center
        self.image = nil
        self.tintColor = nil
    }
}

typealias ImageCell = WrapperCell<UIImageView>
