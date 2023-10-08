//
//  HomeModels.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Foundation

enum HomeViewItem {
    case text(Label.Item)
    case card(Card)
    case createCard
    case transaction(C2CTransfer)
}
