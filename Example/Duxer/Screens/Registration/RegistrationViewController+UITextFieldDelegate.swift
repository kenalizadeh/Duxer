//
//  RegistrationViewController+UITextFieldDelegate.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

extension RegistrationViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text,
              let textRange = Range(range, in: text),
              let type = RegistrationViewInputItem(rawValue: textField.tag)
        else { return true }

        var updatedText = text.replacingCharacters(in: textRange, with: string)

        if case .phoneNumber = type {
            updatedText = PhoneNumberFormatter().decoded(text: updatedText)
        }

        defer {
            switch type {
            case .firstName:
                self.formData.firstName = textField.text

            case .lastName:
                self.formData.lastName = textField.text

            case .phoneNumber:
                self.formData.phoneNumber = PhoneNumberFormatter().decoded(text: textField.text.orEmpty)
            }
        }

        switch type {
        case .firstName, .lastName:
            if updatedText.count <= 25 {
                textField.text = updatedText
            }

        case .phoneNumber:
            textField.text = PhoneNumberFormatter().encoded(text: updatedText)
        }

        return false
    }
}
