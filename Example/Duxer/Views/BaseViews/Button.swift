//
//  Button.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import UIKit

class Button: UIButton {

    var defaultBackgroundColor: UIColor? {
        didSet {
            self.updateBackgroundColor()
        }
    }

    var disabledBackgroundColor: UIColor? {
        didSet {
            self.updateBackgroundColor()
        }
    }

    override var isEnabled: Bool {
        didSet {
            self.updateBackgroundColor()
        }
    }

    private var backgroundColorForCurrentState: UIColor? {
        self.isEnabled
        ? self.defaultBackgroundColor
        : self.disabledBackgroundColor
    }

    func updateBackgroundColor() {

        self.backgroundColor = backgroundColorForCurrentState
    }
}
