//
//  TransferViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit

final class TransferViewController: ViewController {

    private lazy var tableView: UITableView = .build(self.buildTableView)
    private lazy var continueButton: Button = .build(self.buildContinuteButton)

    var tableData: [TransferViewItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    let card: Card

    var transferForm: TransferForm {
        didSet {
            self.evaluateFormData()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(card: Card) {
        self.card = card
        self.transferForm = TransferForm(sender: card)

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = [
            self.tableView,
            self.continueButton
        ]
    }

    override func render(state: DXAppState) {

        self.transferForm.recipient = state.transaction.pendingTransfer?.recipient
        self.tableData = makeTableData(form: self.transferForm)

        if state.transaction.transferSuccess {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

private extension TransferViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.separatorStyle = .none
        v.register(CardCell.self)
        v.register(LabelCell.self)
        v.register(ImageCell.self)
        v.register(TextFieldCell.self)
        v.delegate = self
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
        self.continueButton.isEnabled = self.transferForm.isValid
    }

    @objc
    func continueButtonActionHandler() {
        self.store.dispatch(DXAction.transfer(.pendingTransferFormUpdate(self.transferForm)))

        guard let transferData = self.transferForm.transferData
        else { return }

        self.store.dispatch(transactionThunk(data: transferData))
    }
}

fileprivate func makeTableData(form: TransferForm) -> [TransferViewItem] {

    var tableData: [TransferViewItem] = [
        .card(form.sender),
        .icon(
            .init(
                contentMode: .scaleAspectFit,
                image: .arrowDown,
                tintColor: .systemTeal
            )
        )
    ]

    if let recipient = form.recipient {
        tableData.append(
            .card(recipient)
        )
    } else {
        tableData.append(
            .text(
                .init(
                    content: .init(
                        string: "Select card",
                        color: .white,
                        font: .systemFont(ofSize: 15 ,weight: .semibold)
                    ),
                    textAlignment: .center,
                    backgroundColor: .systemTeal,
                    cornerRadius: 8
                )
            )
        )
    }

    tableData.append(
        .input(
            item: .init(
                placeholder: .init(
                    string: String(Double.zero),
                    color: .lightGray,
                    font: .systemFont(ofSize: 13)
                ),
                borderColor: .systemTeal,
                cornerRadius: 8,
                editingInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                placeholderInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                textInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                keyboardType: .decimalPad,
                leftView: Label.build { v in
                    v.insets = .init(top: 0, left: 10, bottom: 0, right: 0)
                    v.text = "₼"
                    v.textAlignment = .right
                    v.font = .systemFont(ofSize: 20, weight: .medium)
                    v.textColor = .systemTeal
                }
            )
        )
    )

    return tableData
}
