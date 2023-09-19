//
//  UIDatePicker+ConfigurableView.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import UIKit

extension UIDatePicker: ConfigurableView {

    public struct Item {
        let datePickerMode: UIDatePicker.Mode
        let date: Date?
        let minimumDate: Date?
        let maximumDate: Date?
        let horizontalAlignment: UIControl.ContentHorizontalAlignment

        init(
            datePickerMode: UIDatePicker.Mode,
            date: Date? = nil,
            minimumDate: Date? = nil,
            maximumDate: Date? = nil,
            horizontalAlignment: UIControl.ContentHorizontalAlignment = .center
        ) {
            self.datePickerMode = datePickerMode
            self.date = date
            self.minimumDate = minimumDate
            self.maximumDate = maximumDate
            self.horizontalAlignment = horizontalAlignment
        }
    }

    public func configure(_ item: Item) {
        self.datePickerMode = item.datePickerMode
        self.date = item.date.or(.init())
        self.minimumDate = item.minimumDate
        self.maximumDate = item.maximumDate
        self.contentHorizontalAlignment = item.horizontalAlignment
    }

    public func reset() {
        self.datePickerMode = .dateAndTime
        self.date = .init()
        self.minimumDate = nil
        self.maximumDate = nil
        self.contentHorizontalAlignment = .center
    }
}

typealias DatePickerCell = WrapperCell<UIDatePicker>
