//
//  GetWeeklyConsumptionUseCase.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

struct GetWeeklyConsumptionUseCase {
    private let localStorage: LocalStorageManagerable
    
    init(localStorage: LocalStorageManagerable) {
        self.localStorage = localStorage
    }
    
    func execute(ymd: YearMonthDay) -> WeeklyConsumption {
        let dto = localStorage.getWeeklyConsumption(ymd: ymd)
        let weeklyConsumtionList = dto.compactMap {
            let consumptionList = $0.consumptionList.compactMap {
                return Consumption(id: $0.id,
                                   date: $0.date,
                                   title: $0.title,
                                   category: $0.category,
                                   amount: $0.amount)
            }
            return DailyConsumption(year: $0.year,
                                    month: $0.month,
                                    day: $0.day,
                                    consumptionList: consumptionList.sorted(by: {
                $0.date > $1.date
            }))
        }
        
        return WeeklyConsumption(weeklyConsumptionList: weeklyConsumtionList)
    }
}
