//
//  OrderCardViewController+UITextFieldDelegate.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit

extension OrderCardViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        if updatedText.count <= 20 {
            textField.text = updatedText
            self.formData.label = updatedText
        }

        return false
    }
}

