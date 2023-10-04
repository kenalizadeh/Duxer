//
//  TransferViewController+UITableViewDelegate.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import UIKit

extension TransferViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = self.tableData[indexPath.row]

        switch item {
        case .text:

            self.navigationController?.pushViewController(TransferCardSelectionViewController(transferForm: self.transferForm), animated: true)

        case let .card(card):

            guard card.id != self.card.id
            else { return }

            self.navigationController?.pushViewController(TransferCardSelectionViewController(transferForm: self.transferForm), animated: true)

        default: break
        }
    }
}
