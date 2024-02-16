//
//  HomeVM.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

import Foundation
import RxRelay

protocol HomeVMable: HomeVMInput, HomeVMOutput {}

protocol HomeVMInput {
    func getInitialHomeInfo()
}

protocol HomeVMOutput {
    var setViewContents: PublishRelay<HomeVM.ViewContents> { get }
}

final class HomeVM: HomeVMable {
    private let getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase
    private let getWeeklyConsumptionUseCase: GetWeeklyConsumptionUseCase
    
    var weeklySectionDateInfo = Date().yearMonthDay()
    
    init(getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase,
         getWeeklyConsumptionUseCase: GetWeeklyConsumptionUseCase) {
        self.getMonthlyConsumptionUseCase = getMonthlyConsumptionUseCase
        self.getWeeklyConsumptionUseCase = getWeeklyConsumptionUseCase
    }
    
    func getInitialHomeInfo() {
        let monthlyConsumption = getMonthlyConsumptionUseCase.execute(year: weeklySectionDateInfo.year,
                                                                      month: weeklySectionDateInfo.month)
        let weeklyConsumptionList = [WeeklyConsumption]()
        let thisWeekInfo = getWeeklyConsumption(year: weeklySectionDateInfo.year,
                                                month: weeklySectionDateInfo.month,
                                                starDay: 5)
        
    }
    
    private func getWeeklyConsumption(year: Int, month: Int, starDay: Int) -> WeeklyConsumption? {
        guard let startDayWeekDay = Date.getWeekday(year: year, month: month, day: starDay) else {
            return nil
        }
        
        var newYear = year
        var newMonth = month
        var newStartDay = starDay
        
        if startDayWeekDay == .SUN {
            print("그대로 쭉 진행")
        } else {
            let weekStartDay = starDay - (startDayWeekDay.rawValue - 1)
            
            if weekStartDay > 0 { //일요일의 날짜가 0보다 클때
                newStartDay = weekStartDay
                
            } else { //일요일의 날짜가 1보다 작을 때
                let lastMonth = month - 1
                //지난 달이 0보다 클 때
                if lastMonth > 0 {
                    newMonth = lastMonth
                    newStartDay = Date.lastDayOfMonth(year: year, month: lastMonth) ?? 0
                //지난 달이 1보다 작을 때
                } else {
                    newYear -= 1
                    newMonth = 12
                    newStartDay = Date.lastDayOfMonth(year: newYear, month: newMonth) ?? 0
                }
            }
        }
        
        let weeklyConsumption = getWeeklyConsumptionUseCase.execute(year: newYear,
                                                                    month: newMonth,
                                                                    startDay: newStartDay)
        
        return weeklyConsumption
    }
    
    //MARK: - Output
    struct ViewContents {
        
    }
    let setViewContents = PublishRelay<ViewContents>()
}
