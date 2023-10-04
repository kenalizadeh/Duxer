//
//  CGRect+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 21.04.23.
//

import UIKit

public extension CGRect {
    func padded(by insets: UIEdgeInsets) -> CGRect {
        inset(by: UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right))
    }
}
