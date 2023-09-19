//
//  TransferCardSelectionViewController+UITableViewDataSource.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

extension TransferCardSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = self.tableData[indexPath.row]

        return tableView.dequeueReusableCell(
            with: CardCell.Item(
                item: .init(
                    label: .init(string: item.label, color: .white, font: .systemFont(ofSize: 15)),
                    networkIcon: item.network.icon,
                    cardNumber: .init(string: item.number, color: .white.withAlphaComponent(0.75), font: .systemFont(ofSize: 13)),
                    cardNumberFormatter: CardNumberFormatter(),
                    balance: .init(string: String(item.balance), color: .white, font: .systemFont(ofSize: 15)),
                    backgroundColor: .systemTeal
                ),
                insets: .init(top: 8, left: 16, bottom: 8, right: 16)
            ),
            for: indexPath
        ) as CardCell
    }
}
