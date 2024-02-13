//
//  GetMonthlyConsumptionUseCase.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/14/24.
//

struct GetMonthlyConsumptionUseCase {
    private let localStorage: LocalStorageManagerable
    
    init(localStorage: LocalStorageManagerable) {
        self.localStorage = localStorage
    }
    
    func execute(year: Int, month: Int) -> MonthlyConsumption {
        let dto = localStorage.getMontlyConsumption(year: year, month: month)
        return MonthlyConsumption(year: dto?.year ?? 0,
                                  month: dto?.month ?? 0,
                                  limitAmount: dto?.limitAmount ?? 0,
                                  dailyConsumptionList: dailyConsumptionList(dto: dto?.dailyConsumptionList))
    }
    
    private func dailyConsumptionList(dto: [DailyConsumptionDTO]?) -> [DailyConsumption] {
        return (dto ?? []).compactMap {
            return DailyConsumption(day: $0.day,
                                    consumptionList: consumptionList(dto: $0.consumptionList))
        }
    }
    
    private func consumptionList(dto: [ConsumptionDTO]) -> [Consumption] {
        return dto.compactMap {
            return Consumption(id: $0.id,
                               date: $0.date,
                               title: $0.title,
                               category: $0.category,
                               amount: $0.amount)
        }
    }
}
