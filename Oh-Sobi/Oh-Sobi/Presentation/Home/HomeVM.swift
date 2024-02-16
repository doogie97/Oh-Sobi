//
//  HomeVM.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

import Foundation

protocol HomeVMable: HomeVMInput, HomeVMOutput {}

protocol HomeVMInput {
    func getInitialHomeInfo()
}

protocol HomeVMOutput {}

final class HomeVM: HomeVMable {
    private let getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase
    private let getWeeklyConsumptionUseCase: GetWeeklyConsumptionUseCase
    
    init(getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase,
         getWeeklyConsumptionUseCase: GetWeeklyConsumptionUseCase) {
        self.getMonthlyConsumptionUseCase = getMonthlyConsumptionUseCase
        self.getWeeklyConsumptionUseCase = getWeeklyConsumptionUseCase
    }
    
    func getMonthlyConsumption() {
        let todayYearMonthDay = Date().yearMonthDay()
        let monthlyConsumption = getMonthlyConsumptionUseCase.execute(year: todayYearMonthDay.year,
                                                                      month: todayYearMonthDay.month)
        let weeklyConsumption = getWeeklyConsumptionUseCase.execute(year: todayYearMonthDay.year,
                                                                    month: todayYearMonthDay.month,
                                                                    startDay: todayYearMonthDay.day)
        weeklyConsumption.weeklyConsumptionList.forEach {
            print($0?.day)
        }
    func getInitialHomeInfo() {
    }
}
