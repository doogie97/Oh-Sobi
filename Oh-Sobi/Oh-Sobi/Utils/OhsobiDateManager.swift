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
    
    enum DayOfTheWeek: Int {
        case SUN = 1
        case MON
        case TUE
        case WED
        case THU
        case FRI
        case SAT
        
        var shortKorean: String {
            switch self {
            case .SUN:
                return "일"
            case .MON:
                return "월"
            case .TUE:
                return "화"
            case .WED:
                return "수"
            case .THU:
                return "목"
            case .FRI:
                return "금"
            case .SAT:
                return "토"
            }
        }
    }
    
    func getWeekday(ymd: YearMonthDay) -> DayOfTheWeek? {
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.year = ymd.year
        components.month = ymd.month
        components.day = ymd.day
        
        if let date = calendar.date(from: components) {
            let weekdayInt = calendar.component(.weekday, from: date)
            return DayOfTheWeek(rawValue: weekdayInt) ?? nil
        } else {
            return nil
        }
    }
    
    /// 한 주의 일요일 YMD
    ///
    /// - Parameters:
    ///   - ymd : 전달 받은 날짜
    /// - Returns: 전달 받은 ymd 주의 일요일 ymd 반환
    func getWeekSundayYMD(ymd: YearMonthDay) -> YearMonthDay {
        let weekDay = OhsobiDateManager.shared.getWeekday(ymd: ymd) ?? .SUN
        var year = ymd.year
        var month = ymd.month
        var day = ymd.day
        
        let weekStartDay = day - (weekDay.rawValue - 1)
        
        if weekStartDay > 0 { //일요일의 날짜가 0보다 클때
            let lastDay = lastDayOfMonth(year: year, month: month) ?? 0
            if day > lastDay {
                let nextMonth = month + 1
                if nextMonth > 12 {
                    year += 1
                    month = 1
                } else {
                    month += 1
                }
                day = weekStartDay - lastDay
            } else {
                day = weekStartDay
            }
        } else { //일요일의 날짜가 1보다 작을 때
            let lastMonth = month - 1
            //지난 달이 0보다 클 때
            if lastMonth > 0 {
                month = lastMonth
                day = (OhsobiDateManager.shared.lastDayOfMonth(year: year, month: lastMonth) ?? 0) + weekStartDay
                //지난 달이 1보다 작을 때
            } else {
                year -= 1
                month = 12
                day = 31 + weekStartDay
            }
        }
        
        return YearMonthDay(year: year, month: month, day: day)
    }
}
