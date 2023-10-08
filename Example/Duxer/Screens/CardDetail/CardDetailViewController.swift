//
//  CardDetailViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

final class CardDetailViewController: ViewController<AppState> {

    lazy var tableView: UITableView = .build(self.buildTableView)

    var tableData: [CardDetailViewItem] = makeTableData() {
        didSet {
            self.tableView.reloadData()
        }
    }

    var card: Card

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(card: Card) {
        self.card = card

        super.init(nibName: nil, bundle: nil)
        self.setupStateSubscription(projector: AppStateProjector)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setRightBarButtonItems([UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.removeCardButtonAction))], animated: true)
        _ = self.tableView
    }

    override func render(state: AppState) {

        if let card = state.card.cards.first(where: { $0.id == self.card.id }) {
            self.card = card
        }

        let cardTransactions = state.transaction.transactions.filter {
            $0.sender.id == card.id || $0.recipient.id == card.id
        }

        self.tableData = makeTableData(transactions: cardTransactions)
    }
}

private extension CardDetailViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.separatorStyle = .none
        v.register(CardCell.self)
        v.register(LabelCell.self)
        v.register(ButtonCell.self)
        v.register(TransferCell.self)
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

    @objc
    func removeCardButtonAction() {

        self.store.dispatch(CardAction.delete(self.card))
        self.navigationController?.popViewController(animated: true)
    }
}

fileprivate func makeTableData(transactions: [C2CTransfer] = []) -> [CardDetailViewItem] {
    [
        .cardDetails,
        .button(
            .init(
                image: Image.transfer.uiImage,
                text: .init(
                    string: "Transfer",
                    color: .systemTeal,
                    font: .systemFont(ofSize: 20)
                ),
                tintColor: .systemTeal
            )
        ),
        .text(
            .init(
                content: .init(string: "Transaction History", color: .systemTeal, font: .systemFont(ofSize: 15)),
                textAlignment: .center,
                insets: .init(top: 0, left: 0, bottom: 5, right: 0)
            )
        )
    ] + transactions.map(CardDetailViewItem.transaction)
}
