//
//  TextField.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

public class TextField: UITextField {
    public var editingInsets: UIEdgeInsets = .zero
    public var placeholderInsets: UIEdgeInsets = .zero
    public var textInsets: UIEdgeInsets = .zero

    public var allowCopy = true
    public var allowCut = true
    public var allowPaste = true

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds.inset(by: self.editingInsets))
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds.inset(by: self.placeholderInsets))
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds.inset(by: self.textInsets))
    }

    public override func caretRect(for position: UITextPosition) -> CGRect {
        super.caretRect(for: position)
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return allowCopy

        } else if action == #selector(UIResponderStandardEditActions.cut(_:)) {
            return allowCut

        } else if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return allowPaste
        }

        return super.canPerformAction(action, withSender: sender)
    }
}
