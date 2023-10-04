//
//  Double+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import Foundation

extension Double {

    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
