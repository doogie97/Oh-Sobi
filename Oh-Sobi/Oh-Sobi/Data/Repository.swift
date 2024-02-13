//
//  Repository.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/13/24.
//

import Foundation

final class Repository: Repositoryable {
    func getMontlyConsumption(year: Int, month: Int) -> MontlyConsumptionDTO {
        var consumptionList = [DailyConsumptionDTO]()
        for day in 1...14 {
            consumptionList.append(DailyConsumptionDTO(id: UUID(),
                                                       limitAmt: 10000,
                                                       title: "\(day)일 소비 타이틀",
                                                       category: "테스트",
                                                       amount: day * 100 + 2000))
        }
        
        let monthlyConsuption = MontlyConsumptionDTO(id: UUID(),
                                                     year: year,
                                                     month: month,
                                                     limitAmt: 10000,
                                                     consumptionList: consumptionList)
        
        return monthlyConsuption
    }
}
