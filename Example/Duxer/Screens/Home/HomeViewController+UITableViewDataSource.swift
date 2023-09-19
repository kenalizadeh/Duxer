//
//  HomeViewController+UITableViewDataSource.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        self.tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cardItem = self.tableData[indexPath.row]
        let cell: UITableViewCell

        switch cardItem {
        case let .text(item):

            cell = tableView.dequeueReusableCell(
                with: LabelCell.Item(
                    item: item,
                    insets: .init(top: 20, left: 16, bottom: 0, right: 16)
                ),
                for: indexPath
            ) as LabelCell

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

        case .createCard:

            cell = tableView.dequeueReusableCell(
                with: ImageCell.Item(
                    item: .init(
                        contentMode: .scaleAspectFit,
                        image: Image.addCard,
                        tintColor: .systemTeal
                    ),
                    insets: .init(top: 8, left: 16, bottom: 8, right: 16),
                    height: 48
                ),
                for: indexPath
            ) as ImageCell

        case let .transaction(item):

            cell = tableView.dequeueReusableCell(
                with: .init(
                    item: item,
                    insets: .init(top: 2, left: 16, bottom: 2, right: 16)
                ),
                for: indexPath
            ) as TransferCell
        }

        return cell
    }
}
