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
    
    func execute(year: Int, month: Int, startDay: Int) -> [DailyConsumption?] {
        let dto = localStorage.getWeeklyConsumption(year: year, month: month, startDay: startDay)
        return dto.compactMap {
            if let dailyConsumption = $0 {
                let consumptionList = dailyConsumption.consumptionList.compactMap {
                    return Consumption(id: $0.id,
                                       date: $0.date,
                                       title: $0.title,
                                       category: $0.category,
                                       amount: $0.amount)
                }
                return DailyConsumption(day: dailyConsumption.day,
                                        consumptionList: consumptionList.sorted(by: {
                    $0.date > $1.date
                }))
            } else {
                return nil
            }
        }
    }
}
