//
//  HomeViewController+UITableView.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = self.tableData[indexPath.row]

        switch item {
        case let .card(card):
            self.navigationController?.pushViewController(CardDetailViewController(card: card), animated: true)

        case .createCard:
            self.navigationController?.pushViewController(OrderCardViewController(), animated: true)

        case .text, .transaction:
            break
        }
    }
}
