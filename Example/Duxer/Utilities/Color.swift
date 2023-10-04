//
//  Color.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import UIKit

enum Color: String {
    case systemBackground = "BackgroundWhite"

    var uiColor: UIColor? {
        UIColor(named: self.rawValue)
    }
}
