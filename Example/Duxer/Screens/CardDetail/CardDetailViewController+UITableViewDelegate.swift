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

            self.dispatch(TransferAction.pendingTransferFormUpdate(.init(sender: self.card)))
            self.dispatch(NavigationAction.transfer(card: self.card))

        default: break
        }
    }
}
