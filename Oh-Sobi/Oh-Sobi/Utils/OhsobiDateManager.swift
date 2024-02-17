//
//  OhsobiDateManager.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/17/24.
//

import Foundation

final class OhsobiDateManager {
    static let shared = OhsobiDateManager()
    private init() {}
    func lastDayOfMonth(year: Int, month: Int) -> Int? {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: year, month: month, day: 1))!) else {
            return nil
        }
        return range.count
    }
    
    func stringToDate(year: Int, month: Int, day: Int) -> Date {
        return Date()
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
    
    func getWeekday(year: Int, month: Int, day: Int) -> Day? {
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
