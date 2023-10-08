//
//  UIView+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
