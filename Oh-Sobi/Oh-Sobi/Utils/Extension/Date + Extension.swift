//
//  Date + Extension.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

import Foundation

extension Date {
    static func lastDayOfMonth(year: Int, month: Int) -> Int? {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: year, month: month, day: 1))!) else {
            return nil
        }
        return range.count
    }
}
