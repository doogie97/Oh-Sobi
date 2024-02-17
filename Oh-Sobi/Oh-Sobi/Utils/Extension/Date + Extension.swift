//
//  Date + Extension.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

import Foundation

extension Date {

    
    func yearMonthDay() -> YearMonthDay {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        return YearMonthDay(year: components.year ?? 0,
                            month: components.month ?? 0,
                            day: components.day ?? 0)
    }
}
