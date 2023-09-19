//
//  Image.swift
//  DuxerExample
//
//  Created by 004230 on 21.04.23.
//

import UIKit

enum Image: String {
    case cardTypeAmex
    case cardTypeMaestro
    case cardTypeMaster
    case cardTypeUnionpay
    case cardTypeVisa

    case addCard = "plus.circle"
    case transfer = "arrow.left.arrow.right.square"
    case arrowDown = "arrow.down.app"

    var repository: Repository {
        switch self {
        case .cardTypeAmex, .cardTypeMaestro, .cardTypeMaster, .cardTypeUnionpay, .cardTypeVisa:
            return .assetsCatalog

        case .addCard, .transfer, .arrowDown:
            return .system
        }
    }

    enum Repository {
        case system
        case assetsCatalog
    }
}

extension Image {

    var uiImage: UIImage? {
        switch self.repository {
        case .system:
            return UIImage(systemName: self.rawValue)

        case .assetsCatalog:
            return UIImage(named: self.rawValue)
        }
    }
}
