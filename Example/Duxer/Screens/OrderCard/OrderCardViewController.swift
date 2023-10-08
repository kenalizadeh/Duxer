//
//  OrderCardViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

final class OrderCardViewController: ViewController<CardState> {

    private lazy var tableView: UITableView = .build(self.buildTableView)
    private lazy var continueButton: Button = .build(self.buildContinuteButton)

    private let cardID: String = UUID().uuidString

    let tableData: [OrderCardViewItem] = makeTableData()

    var formData = OrderCardForm() {
        didSet {
            self.evaluateFormData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStateSubscription(projector: CardStateProjector)

        self.title = "Order Card"

        _ = [
            self.tableView,
            self.continueButton
        ]
    }
}

private extension OrderCardViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.separatorStyle = .none
        v.register(LabelCell.self)
        v.register(TextFieldCell.self)
        v.register(SegmentCell.self)
        v.dataSource = self
        v.contentInsetAdjustmentBehavior = .never

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

        guard let card = self.formData.card
        else { return }

        self.store.dispatch(CardAction.create(card))
        self.navigationController?.popViewController(animated: true)
    }
}

fileprivate func makeTableData() -> [OrderCardViewItem] {
    [
        .text(
            content: .init(
                string: "Enter card name",
                color: .darkGray,
                font: .systemFont(ofSize: 15, weight: .bold)
            )
        ),
        .input(
            type: .cardLabel,
            item: .init(
                placeholder: .init(
                    string: "Visa Digital",
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
        .options(Currency.allCases)
    ]
}

