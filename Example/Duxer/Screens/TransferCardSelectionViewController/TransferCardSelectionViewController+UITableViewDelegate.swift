//
//  TransferCardSelectionViewController+UITableViewDelegate.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

extension TransferCardSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let card = self.tableData[indexPath.row]
        self.transferForm.recipient = card

        self.store.dispatch(DXAction.transfer(.pendingTransferFormUpdate(self.transferForm)))
        self.navigationController?.popViewController(animated: true)
    }
}
