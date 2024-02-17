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
    
    let dateFormatter = DateFormatter()
    
    func lastDayOfMonth(year: Int, month: Int) -> Int? {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: year, month: month, day: 1))!) else {
            return nil
        }
        return range.count
    }
    
    func ymdToDate(ymd: YearMonthDay) -> Date {
        dateFormatter.dateFormat = "yyyy.M.d"
        let dateString = "\(ymd.year).\(ymd.month).\(ymd.day)"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        return date
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
    
    func getWeekday(ymd: YearMonthDay) -> Day? {
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.year = ymd.year
        components.month = ymd.month
        components.day = ymd.day
        
        if let date = calendar.date(from: components) {
            let weekdayInt = calendar.component(.weekday, from: date)
            return Day(rawValue: weekdayInt) ?? nil
        } else {
            return nil
        }
    }
}
