//
//  Color.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import UIKit

enum Color: String {
    case systemBackground = "BackgroundWhite"

    var uiColor: UIColor? {
        UIColor(named: self.rawValue)
    }
}
