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
        let thisWeekInfo = getWeeklyConsumptionUseCase.execute(ymd: YearMonthDay(year: 2024, month: 1, day: 1))
        
    }
    
    //MARK: - Output
    struct ViewContents {
        
    }
    let setViewContents = PublishRelay<ViewContents>()
}
