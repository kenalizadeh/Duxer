//
//  UIView+Extensions.swift
//  DuxerExample
//
//  Created by 004230 on 22.04.23.
//

import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
