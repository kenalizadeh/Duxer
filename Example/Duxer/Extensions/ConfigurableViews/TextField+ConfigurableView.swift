//
//  TextField+ConfigurableView.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit
import WrapperCell

extension TextField: ConfigurableView {

    public struct Item {
        let placeholder: TextContent
        let borderColor: UIColor?
        let cornerRadius: CGFloat?
        let editingInsets: UIEdgeInsets
        let placeholderInsets: UIEdgeInsets
        let textInsets: UIEdgeInsets
        let keyboardType: UIKeyboardType
        let autocapitalizationType: UITextAutocapitalizationType
        let textColor: UIColor?
        let font: UIFont?
        let leftView: UIView?
        let rightView: UIView?

        init(
            placeholder: TextContent,
            borderColor: UIColor? = nil,
            cornerRadius: CGFloat? = nil,
            editingInsets: UIEdgeInsets = .zero,
            placeholderInsets: UIEdgeInsets = .zero,
            textInsets: UIEdgeInsets = .zero,
            keyboardType: UIKeyboardType = .default,
            autocapitalizationType: UITextAutocapitalizationType = .sentences,
            textColor: UIColor? = nil,
            font: UIFont? = nil,
            leftView: UIView? = nil,
            rightView: UIView? = nil
        ) {
            self.placeholder = placeholder
            self.borderColor = borderColor
            self.cornerRadius = cornerRadius
            self.editingInsets = editingInsets
            self.placeholderInsets = placeholderInsets
            self.textInsets = textInsets
            self.keyboardType = keyboardType
            self.autocapitalizationType = autocapitalizationType
            self.textColor = textColor
            self.font = font
            self.leftView = leftView
            self.rightView = rightView
        }
    }

    public func configure(_ item: Item) {
        self.attributedPlaceholder = .init(from: item.placeholder)
        self.layer.borderColor = item.borderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = item.cornerRadius.orZero
        self.editingInsets = item.editingInsets
        self.placeholderInsets = item.placeholderInsets
        self.textInsets = item.textInsets
        self.keyboardType = item.keyboardType
        self.autocapitalizationType = item.autocapitalizationType
        self.textColor = item.textColor
        self.font = item.font
        self.leftView = item.leftView
        self.leftViewMode = .always
        self.rightView = item.rightView
        self.rightViewMode = .always
    }

    public func reset() {
        self.attributedPlaceholder = nil
        self.layer.borderColor = nil
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.editingInsets = .zero
        self.placeholderInsets = .zero
        self.textInsets = .zero
        self.keyboardType = .default
        self.autocapitalizationType = .sentences
        self.textColor = nil
        self.font = nil
        self.leftView = nil
        self.leftViewMode = .never
        self.rightView = nil
        self.rightViewMode = .never
    }
}

typealias TextFieldCell = WrapperCell<TextField>
