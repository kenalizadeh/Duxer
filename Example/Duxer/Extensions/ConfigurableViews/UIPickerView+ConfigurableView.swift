//
//  UIPickerView+ConfigurableView.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
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
