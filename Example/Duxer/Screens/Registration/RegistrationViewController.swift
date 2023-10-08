//
//  RegistrationViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit
import Duxer

final class RegistrationViewController: ViewController<UserState> {

    lazy var tableView: UITableView = .build(self.buildTableView)
    lazy var continueButton: Button = .build(self.buildContinuteButton)

    lazy var tapGestureRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(self.endEditing))

    let tableData: [RegistrationViewItem] = makeTableData()

    var formData = RegistrationForm(birthDate: Calendar.current.date(byAdding: .init(year: -18), to: .init())) {
        didSet {
            self.evaluateFormData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = [
            self.tableView,
            self.continueButton
        ]

        self.view.addGestureRecognizer(self.tapGestureRecognizer)
    }

    override func render(state: UserState) {

        guard state.userData.isNotNil
        else { return }

        self.navigationController?.setViewControllers([HomeViewController()], animated: true)
    }

    @objc
    func datePickerValueChanged(_ datePicker: UIDatePicker) {

        self.formData.birthDate = datePicker.date
    }
}

private extension RegistrationViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.register(LabelCell.self)
        v.register(DatePickerCell.self)
        v.register(TextFieldCell.self)
        v.separatorStyle = .none
        v.dataSource = self
        v.contentInset.bottom = 90

        self.view.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func buildContinuteButton(_ v: inout Button) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(self.continueButtonActionHandler), for: .touchUpInside)
        v.setTitle("Continue", for: [])
        v.clipsToBounds = true
        v.roundCorners(.allCorners, radius: 8)
        v.defaultBackgroundColor = .systemBlue
        v.disabledBackgroundColor = .lightGray
        v.isEnabled = false

        self.view.addSubview(v)
        NSLayoutConstraint.activate([
            v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            v.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            v.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32),
            v.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func evaluateFormData() {

        self.continueButton.isEnabled = self.formData.isValid
    }

    @objc
    func continueButtonActionHandler() {
        guard let userData = self.formData.userData
        else { return }

        AppDelegate.shared.store.dispatch(UserAction.register(userData))
    }

    @objc
    func endEditing() {

        self.view.endEditing(true)
    }
}

fileprivate func makeTableData() -> [RegistrationViewItem] {
    [
        .text(
            content: .init(
                string: "Enter first name",
                color: .darkGray,
                font: .systemFont(ofSize: 15, weight: .bold)
            )
        ),
        .input(
            type: .firstName,
            item: .init(
                placeholder: .init(
                    string: "John",
                    color: .lightGray,
                    font: .systemFont(ofSize: 13)
                ),
                borderColor: .darkGray,
                cornerRadius: 8,
                editingInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                placeholderInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                textInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                keyboardType: .default
            )
        ),
        .text(
            content: .init(
                string: "Enter last name",
                color: .darkGray,
                font: .systemFont(ofSize: 15, weight: .bold)
            )
        ),
        .input(
            type: .lastName,
            item: .init(
                placeholder: .init(
                    string: "Doe",
                    color: .lightGray,
                    font: .systemFont(ofSize: 13)
                ),
                borderColor: .darkGray,
                cornerRadius: 8,
                editingInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                placeholderInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                textInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                keyboardType: .default
            )
        ),
        .text(
            content: .init(
                string: "Enter phone number",
                color: .darkGray,
                font: .systemFont(ofSize: 15, weight: .bold)
            )
        ),
        .input(
            type: .phoneNumber,
            item: .init(
                placeholder: .init(
                    string: "(+994) XX XXX XX XX",
                    color: .lightGray,
                    font: .systemFont(ofSize: 13)
                ),
                borderColor: .darkGray,
                cornerRadius: 8,
                editingInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                placeholderInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                textInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                keyboardType: .numberPad
            )
        ),
        .text(
            content: .init(
                string: "Must be at least 18 to continue",
                color: .darkGray,
                font: .systemFont(ofSize: 15, weight: .bold)
            )
        ),
        .date(
            item: .init(
                datePickerMode: .date,
                date: Calendar.current.date(byAdding: .init(year: -18), to: .init()),
                maximumDate: Calendar.current.date(byAdding: .init(year: -18), to: .init()),
                horizontalAlignment: .leading
            )
        )
    ]
}
