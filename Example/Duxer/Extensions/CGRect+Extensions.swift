//
//  CGRect+Extensions.swift
//  DuxerExample
//
//  Created by 004230 on 21.04.23.
//

import UIKit

public extension CGRect {
    func padded(by insets: UIEdgeInsets) -> CGRect {
        inset(by: UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right))
    }
}
