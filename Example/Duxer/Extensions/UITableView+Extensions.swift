//
//  UITableView+Extensions.swift
//  DuxerExample
//
//  Created by 004230 on 21.04.23.
//

import UIKit

extension UITableView {

    func register<V>(_ cellType: WrapperCell<V>.Type) {
        register(cellType, forCellReuseIdentifier: cellType.uniqueIdentifier)
    }

    func dequeueReusableCell<V: ConfigurableView>(with item: WrapperCell<V>.Item, for indexPath: IndexPath) -> WrapperCell<V> {
        typealias Cell = WrapperCell<V>

        let identifier = Cell.uniqueIdentifier
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        guard let cell = cell as? Cell
        else { fatalError("Unable to dequeue cell type: \(Cell.self) with reuseIdentifier: \(Cell.uniqueIdentifier). Make sure specified cell type is registered.") }

        cell.configure(item)

        return cell
    }
}
