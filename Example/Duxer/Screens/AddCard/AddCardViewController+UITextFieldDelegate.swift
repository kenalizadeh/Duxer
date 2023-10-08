//
//  AddCardViewController+UITextFieldDelegate.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

extension AddCardViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text,
              let textRange = Range(range, in: text),
              let type = AddCardViewInputItem(rawValue: textField.tag)
        else { return true }

        var updatedText = text.replacingCharacters(in: textRange, with: string)

        switch type {
        case .cardNumber:
            updatedText = CardNumberFormatter().decoded(text: updatedText)

        case .expirationDate:
            updatedText = CardExpirationDateFormatter().decoded(text: updatedText)

        default: break
        }

        defer {
            switch type {
            case .cardLabel:
                self.formData.label = textField.text

            case .expirationDate:
                self.formData.expirationDate = CardExpirationDateFormatter().decoded(text: textField.text.orEmpty)

            case .cvv:
                self.formData.cvv = textField.text

            case .cardNumber:
                self.formData.number = CardNumberFormatter().decoded(text: textField.text.orEmpty)
            }
        }

        switch type {
        case .cardLabel:
            if updatedText.count <= 20 {
                textField.text = updatedText
            }

        case .cardNumber:
            textField.text = CardNumberFormatter().encoded(text: updatedText)

        case .expirationDate:
            textField.text = CardExpirationDateFormatter().encoded(text: updatedText)

        case .cvv:
            if updatedText.count <= 3 {
                textField.text = updatedText
            }
        }

        return false
    }
}
