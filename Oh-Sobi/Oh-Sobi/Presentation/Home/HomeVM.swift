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
        let weeklyConsumption = getWeeklyConsumptionUseCase.execute(ymd: Date().yearMonthDay())
        setViewContents.accept(ViewContents(weeklyConsumption: weeklyConsumption))
    }
    
    //MARK: - Output
    struct ViewContents {
        let weeklyConsumption: WeeklyConsumption
    }
    let setViewContents = PublishRelay<ViewContents>()
}
