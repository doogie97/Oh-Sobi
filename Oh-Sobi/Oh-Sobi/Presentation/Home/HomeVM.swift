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
        let thisWeekInfo = getWeeklyConsumption(ymd: YearMonthDay(year: weeklySectionDateInfo.year, month: weeklySectionDateInfo.month, day: 5))
        
    }
    
    private func getWeeklyConsumption(ymd: YearMonthDay) -> WeeklyConsumption? {
        guard let startDayWeekDay = OhsobiDateManager.shared.getWeekday(ymd: ymd) else {
            return nil
        }
        
        var year = ymd.year
        var month = ymd.month
        var startDay = ymd.day
        
        if startDayWeekDay == .SUN {
            print("그대로 쭉 진행")
        } else {
            let weekStartDay = startDay - (startDayWeekDay.rawValue - 1)
            
            if weekStartDay > 0 { //일요일의 날짜가 0보다 클때
                startDay = weekStartDay
                
            } else { //일요일의 날짜가 1보다 작을 때
                let lastMonth = month - 1
                //지난 달이 0보다 클 때
                if lastMonth > 0 {
                    month = lastMonth
                    startDay = OhsobiDateManager.shared.lastDayOfMonth(year: year, month: lastMonth) ?? 0
                //지난 달이 1보다 작을 때
                } else {
                    year -= 1
                    month = 12
                    startDay = OhsobiDateManager.shared.lastDayOfMonth(year: year, month: month) ?? 0
                }
            }
        }
        
        let weeklyConsumption = getWeeklyConsumptionUseCase.execute(ymd: YearMonthDay(year: year, month: month, day: startDay))
        
        return weeklyConsumption
    }
    
    //MARK: - Output
    struct ViewContents {
        
    }
    let setViewContents = PublishRelay<ViewContents>()
}
