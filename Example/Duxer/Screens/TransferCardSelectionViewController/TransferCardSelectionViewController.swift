//
//  TransferCardSelectionViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit

final class TransferCardSelectionViewController: ViewController<DXCardState> {

    private lazy var tableView: UITableView = .build(self.buildTableView)

    var tableData: [Card] = []

    var transferForm: TransferForm

    override var stateProjector: StateProjector? { CardStateProjector }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(transferForm: TransferForm) {
        self.transferForm = transferForm

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.tableView
    }

    override func render(state: DXCardState) {

        let cards = state.cards.filter { $0.id != self.transferForm.sender.id }

        self.tableData = cards
        self.tableView.reloadData()
    }
}

private extension TransferCardSelectionViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.separatorStyle = .none
        v.register(CardCell.self)
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
}
