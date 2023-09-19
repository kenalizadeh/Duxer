//
//  TransferViewController+UITableViewDataSource.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

extension TransferViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = self.tableData[indexPath.row]
        let cell: UITableViewCell

        switch item {
        case let .card(card):

            cell = tableView.dequeueReusableCell(
                with: CardCell.Item(
                    item: .init(
                        label: .init(string: card.label, color: .white, font: .systemFont(ofSize: 15)),
                        networkIcon: card.network.icon,
                        cardNumber: .init(string: card.number, color: .white.withAlphaComponent(0.75), font: .systemFont(ofSize: 13)),
                        cardNumberFormatter: CardNumberFormatter(),
                        balance: .init(string: String(card.balance), color: .white, font: .systemFont(ofSize: 15)),
                        backgroundColor: .systemTeal
                    ),
                    insets: .init(top: 8, left: 16, bottom: 8, right: 16)
                ),
                for: indexPath
            ) as CardCell

        case let .text(item):

            cell = tableView.dequeueReusableCell(
                with: LabelCell.Item(
                    item: item,
                    insets: .init(top: 20, left: 16, bottom: 20, right: 16),
                    height: 60
                ),
                for: indexPath
            ) as LabelCell

        case let .icon(item):

            cell = tableView.dequeueReusableCell(
                with: ImageCell.Item(
                    item: item,
                    insets: .init(top: 8, left: 16, bottom: 8, right: 16),
                    height: 40
                ),
                for: indexPath
            ) as ImageCell

        case let .input(item):

            let textFieldCell = tableView.dequeueReusableCell(
                with: TextFieldCell.Item(
                    item: item,
                    insets: .init(top: 0, left: 16, bottom: 10, right: 16),
                    height: 44
                ),
                for: indexPath
            ) as TextFieldCell

            textFieldCell.child.delegate = self

            cell = textFieldCell
        }

        return cell
    }
}
