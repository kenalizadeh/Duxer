//
//  LinkCardViewController+UITableViewDataSource.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

extension LinkCardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = self.tableData[indexPath.row]
        let cell: UITableViewCell

        switch item {
        case let .text(content):

            cell = tableView.dequeueReusableCell(
                with: LabelCell.Item(
                    item: .init(content: content),
                    insets: .init(top: 10, left: 16, bottom: 10, right: 16)
                ),
                for: indexPath
            ) as LabelCell

        case let .input(type, item):

            let textFieldCell = tableView.dequeueReusableCell(
                with: TextFieldCell.Item(
                    item: item,
                    insets: .init(top: 0, left: 16, bottom: 10, right: 16),
                    height: 44
                ),
                for: indexPath
            ) as TextFieldCell

            textFieldCell.child.delegate = self
            textFieldCell.child.tag = type.rawValue

            cell = textFieldCell
        }

        return cell
    }
}
