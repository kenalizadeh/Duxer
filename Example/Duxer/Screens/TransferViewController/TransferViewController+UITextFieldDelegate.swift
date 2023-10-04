//
//  TransferViewController+UITextFieldDelegate.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit

extension TransferViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let updatedText = text.replacingCharacters(in: textRange, with: string)

        guard Double(updatedText).orZero < self.card.balance
        else { return false }

        textField.text = updatedText
        self.transferForm.amount = Double(updatedText).orZero

        return false
    }
}
