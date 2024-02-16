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
    
    struct YearMonthDay {
        let year: Int
        let month: Int
        let day: Int
    }
    
    func yearMonthDay() -> YearMonthDay {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        return YearMonthDay(year: components.year ?? 0,
                            month: components.month ?? 0,
                            day: components.day ?? 0)
    }
    
    enum Day: Int {
        case SUN = 1
        case MON
        case TUE
        case WED
        case THU
        case FRI
        case SAT
    }
    
    static func getWeekday(year: Int, month: Int, day: Int) -> Day? {
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        if let date = calendar.date(from: components) {
            let weekdayInt = calendar.component(.weekday, from: date)
            return Day(rawValue: weekdayInt) ?? nil
        } else {
            return nil
        }
    }
}
