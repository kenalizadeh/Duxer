//
//  UIPickerView+ConfigurableView.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit
import WrapperCell

extension UIPickerView: ConfigurableView {

    public struct Item {
        let options: [String]
    }

    public func configure(_ item: Item) {

    }

    public func reset() {

    }
}
