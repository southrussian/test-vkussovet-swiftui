//
//  Formatter.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation

extension String {
    func formatPrice() -> String {
        if let doubleValue = Double(self) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = ""
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.minimumFractionDigits = 0
            let formattedValue = numberFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
            return formattedValue + " ₽"
        }
        return self
    }
}
