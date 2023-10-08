//
//  HomeViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

class HomeViewController: ViewController<AppState> {

    lazy var tableView: UITableView = .build(self.buildTableView)

    var tableData: [HomeViewItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.tableView
        self.title = "Home"
        self.navigationItem.titleView = UIView()

        let addCardItem = UIBarButtonItem(title: "Add Other Card", style: .done, target: self, action: #selector(self.addOtherCardActionHandler))
        self.navigationItem.setRightBarButtonItems([addCardItem], animated: true)
    }

    override func render(state: AppState) {

        let userNameItem: HomeViewItem = .text(
            .init(
                content: .init(string: state.user.userData?.fullName ?? "", color: .darkGray, font: .systemFont(ofSize: 30, weight: .bold)),
                numberOfLines: 0,
                lineBreakMode: .byWordWrapping,
                baselineAdjustment: .alignCenters
            )
        )

        let cardItems: [HomeViewItem] = state.card.cards.isEmpty
        ? [
            .text(
                .init(
                    content: .init(string: "You don't have any cards\nOrder a card by clicking the button below", color: .darkGray, font: .systemFont(ofSize: 15, weight: .semibold)),
                    numberOfLines: 0,
                    lineBreakMode: .byWordWrapping,
                    textAlignment: .center,
                    baselineAdjustment: .alignCenters
                )
            )
        ]
        : state.card.cards.map(HomeViewItem.card)

        let transactionHeaderItem: HomeViewItem = .text(
            .init(
                content: .init(string: state.transaction.transactions.isEmpty ? "No transactions" : "Transaction History", color: .systemTeal, font: .systemFont(ofSize: 15)),
                textAlignment: .center,
                insets: .init(top: 0, left: 0, bottom: 5, right: 0)
            )
        )

        let transactionItems: [HomeViewItem] = state.transaction.transactions.map(HomeViewItem.transaction)

        self.tableData = [userNameItem] + cardItems + [.createCard] + [transactionHeaderItem] + transactionItems
    }
}

private extension HomeViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.register(CardCell.self)
        v.register(LabelCell.self)
        v.register(ImageCell.self)
        v.register(TransferCell.self)
        v.separatorStyle = .none
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
    func addOtherCardActionHandler() {

        self.navigationController?.pushViewController(AddCardViewController(), animated: true)
    }
}
