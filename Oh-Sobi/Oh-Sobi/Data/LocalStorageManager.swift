//
//  LocalStorage.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/13/24.
//

import Foundation

protocol LocalStorageManagerable {
    func getMontlyConsumption(year: Int, month: Int) -> MontlyConsumptionDTO?
    func getDailyConsumption(ymd: YearMonthDay) -> DailyConsumptionDTO?
    func getWeeklyConsumption(ymd: YearMonthDay) -> [DailyConsumptionDTO]
}

//MARK: - 더미 데이터로 저장소 임시구현
final class LocalStorageManager: LocalStorageManagerable {
    private var montlyConsumptionListDTO = [MontlyConsumptionDTO]()
    init() {
        montlyConsumptionListDTO.append(dummyMonthlyDTO(month: 1))
        montlyConsumptionListDTO.append(dummyMonthlyDTO(month: 2))
        montlyConsumptionListDTO.append(dummyMonthlyDTO(month: 3))
    }
    
    func getMontlyConsumption(year: Int, month: Int) -> MontlyConsumptionDTO? {
        return montlyConsumptionListDTO.filter { $0.year == year && $0.month == month }.first
    }
    
    func getDailyConsumption(ymd: YearMonthDay) -> DailyConsumptionDTO? {
        let monthlyConsumption = getMontlyConsumption(year: ymd.year, month: ymd.month)
        return monthlyConsumption?.dailyConsumptionList.filter { $0.day == ymd.day }.first
    }
    
    func getWeeklyConsumption(ymd: YearMonthDay) -> [DailyConsumptionDTO] {
        var weeklyConsumptionList = [DailyConsumptionDTO]()
        
        guard let lastDayOfMonth = OhsobiDateManager.shared.lastDayOfMonth(year: ymd.year, month: ymd.month) else {
            return []
        }
        let monthlyConsumptionsOfstartDay = getMontlyConsumption(year: ymd.year, month: ymd.month)
        
        if (ymd.day + 6) > lastDayOfMonth {
            for day in ymd.day...lastDayOfMonth {
                if let dailyConsumption = monthlyConsumptionsOfstartDay?.dailyConsumptionList.filter({ $0.day == day }).first {
                    weeklyConsumptionList.append(dailyConsumption)
                } else {
                    weeklyConsumptionList.append(DailyConsumptionDTO(year: ymd.year,
                                                                     month: ymd.month,
                                                                     day: day,
                                                                     consumptionList: []))
                }
            }
            
            let overDayCount = 7 - (lastDayOfMonth - ymd.day + 1)
            var nextMonthlyConsumptions: MontlyConsumptionDTO? {
                if ymd.month + 1 > 12 {
                    return getMontlyConsumption(year: ymd.year + 1, month: 1)
                } else {
                    return getMontlyConsumption(year: ymd.year, month: ymd.month + 1)
                }
            }
            
            for day in 1...overDayCount {
                if let dailyConsumption = nextMonthlyConsumptions?.dailyConsumptionList.filter({ $0.day == day }).first {
                    weeklyConsumptionList.append(dailyConsumption)
                } else {
                    weeklyConsumptionList.append(DailyConsumptionDTO(year: ymd.year,
                                                                     month: ymd.month,
                                                                     day: day,
                                                                     consumptionList: []))
                }
            }
        } else {
            for day in ymd.day...ymd.day + 6 {
                if let dailyConsumption = monthlyConsumptionsOfstartDay?.dailyConsumptionList.filter({ $0.day == day }).first {
                    weeklyConsumptionList.append(dailyConsumption)
                } else {
                    weeklyConsumptionList.append(DailyConsumptionDTO(year: ymd.year,
                                                                     month: ymd.month,
                                                                     day: day,
                                                                     consumptionList: []))
                }
            }
        }
        return weeklyConsumptionList
    }
}

//MARK: - DummyCode
extension LocalStorageManager {
    private func dummyMonthlyDTO(month: Int) -> MontlyConsumptionDTO {
        var dailyConsumptionList = [DailyConsumptionDTO]()
        for i in 0..<dummyDaysInMonth(month: month) {
            dailyConsumptionList.append(dummyDailyConsumption(year: 2024, month: month, day: i + 1))
        }
        return MontlyConsumptionDTO(year: 2024,
                                    month: month,
                                    limitAmount: 10000,
                                    dailyConsumptionList: dailyConsumptionList)
    }
    
    private func dummyDaysInMonth(month: Int) -> Int {
        if month == 3 {
            return 14
        }
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = month

        guard let lastDayOfMonth = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: lastDayOfMonth) else {
            return 0
        }

        return range.count
    }
    
    private func dummyDailyConsumption(year: Int, month: Int, day: Int) -> DailyConsumptionDTO {
        let randomInt = Int.random(in: 0..<10)
        if randomInt == 0 {
            return DailyConsumptionDTO(year: year,
                                       month: month,
                                       day: day,
                                       consumptionList: [])
        } else if randomInt == 1 {
            return DailyConsumptionDTO(year: year,
                                       month: month,
                                       day: day,
                                       consumptionList: [dummyConsumption(month: month, day: day, index: 1)])
        } else {
            var consumptionList = [ConsumptionDTO]()
            for i in 0...randomInt {
                consumptionList.append(dummyConsumption(month: month, day: day, index: i + 1))
            }
            
            return DailyConsumptionDTO(year: year,
                                       month: month,
                                       day: day,
                                       consumptionList: consumptionList)
        }
    }
    
    private func dummyConsumption(month: Int, day: Int, index: Int) -> ConsumptionDTO {
        let randomHour = Int.random(in: 0..<24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.M.d H"
        let dateString = "2024.\(month).\(day) \(randomHour)"
        let date = dateFormatter.date(from: dateString) ?? Date()
        let amount = day % 2 == 0 ? 1000 : -1000
        return ConsumptionDTO(id: UUID(),
                              date: date,
                              title: "\(day)일의 \(index)번 상품 소비",
                              category: "테스트",
                              amount: amount * day)
    }
}
