//
//  Color.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

enum Color: String {
    case systemBackground = "BackgroundWhite"

    var uiColor: UIColor? {
        UIColor(named: self.rawValue)
    }
}
