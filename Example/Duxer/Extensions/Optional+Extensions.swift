//
//  Optional+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Foundation

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        map { $0.isEmpty } ?? true
    }
}

public extension Optional where Wrapped == Bool {
    var isNilOrFalse: Bool {
        map { $0 == false } ?? true
    }
}

public extension Optional {
    /// Returns self if not nil or passed value
    /// - Parameter value: fallback value
    /// - Returns: self or fallback value
    func or(_ value: Wrapped) -> Wrapped {
        self ?? value
    }
}

public extension Optional where Wrapped: RangeReplaceableCollection {
    /// Returns self if self is not nil, or empty collection
    var orEmpty: Wrapped {
        self.or(.init())
    }
}

public extension Optional where Wrapped: Numeric {
    /// Returns self if self is not nil, or zero
    var orZero: Wrapped {
        self.or(0)
    }

    var isNilorZero: Bool {
        self.isNil || self == .zero
    }
}

public extension Optional {

    var isNil: Bool {
        self == nil
    }

    var isNotNil: Bool { !self.isNil }
}
