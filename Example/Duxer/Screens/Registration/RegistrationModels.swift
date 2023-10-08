//
//  RegistrationModels.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

enum RegistrationViewItem {
    case text(content: TextContent)
    case date(item: UIDatePicker.Item)
    case input(type: RegistrationViewInputItem, item: TextField.Item)
}

enum RegistrationViewInputItem: Int {
    case firstName
    case lastName
    case phoneNumber
}

struct UserData: Equatable {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var phoneNumber: String

    var fullName: String {
        [
            self.firstName,
            self.lastName
        ].joined(separator: " ")
    }
}

struct RegistrationForm {
    var firstName: String?
    var lastName: String?
    var birthDate: Date?
    var phoneNumber: String?

    var isValid: Bool {

        guard let firstName,
              !firstName.isEmpty,
              let lastName,
              !lastName.isEmpty,
              let birthDate,
              let phoneNumber,
              phoneNumber.count == 9,
              let minimumAllowedBirthDate = Calendar.current.date(byAdding: DateComponents(year: -18), to: .init()),
              minimumAllowedBirthDate > birthDate
        else { return false }

        return true
    }

    var userData: UserData? {

        guard let firstName,
              let lastName,
              let birthDate,
              let phoneNumber
        else { return nil }

        return UserData(
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            phoneNumber: phoneNumber
        )
    }
}
