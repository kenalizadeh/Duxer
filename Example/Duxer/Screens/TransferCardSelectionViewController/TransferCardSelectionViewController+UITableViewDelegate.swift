//
//  TransferCardSelectionViewController+UITableViewDelegate.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

extension TransferCardSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let card = self.tableData[indexPath.row]
        self.transferForm.recipient = card

        self.store.dispatch(TransferAction.pendingTransferFormUpdate(self.transferForm))
        self.navigationController?.popViewController(animated: true)
    }
}
