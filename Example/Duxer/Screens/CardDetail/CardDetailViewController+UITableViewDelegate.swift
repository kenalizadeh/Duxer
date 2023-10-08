//
//  CardDetailViewController+UITableViewDelegate.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

extension CardDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = self.tableData[indexPath.row]

        switch item {
        case .button:

            self.store.dispatch(TransferAction.pendingTransferFormUpdate(.init(sender: self.card)))
            self.navigationController?.pushViewController(TransferViewController(card: self.card), animated: true)

        default: break
        }
    }
}
