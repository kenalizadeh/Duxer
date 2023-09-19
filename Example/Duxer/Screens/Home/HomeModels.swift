//
//  HomeModels.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import Foundation

enum HomeViewItem {
    case text(Label.Item)
    case card(Card)
    case createCard
    case transaction(C2CTransfer)
}
