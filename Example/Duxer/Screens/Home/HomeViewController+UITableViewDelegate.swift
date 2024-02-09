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
            self.dispatch(NavigationAction.cardDetails(card: card))

        case .createCard:
            self.dispatch(NavigationAction.cardOrder)

        case .text, .transaction:
            break
        }
    }
}
