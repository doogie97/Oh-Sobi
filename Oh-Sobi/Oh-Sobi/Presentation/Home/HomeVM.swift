//
//  HomeVM.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

import Foundation
import RxRelay

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func getInitialHomeInfo()
    func touchWeeklyConsumption(_ index: Int)
}

protocol HomeVMOutput {
    var viewContents: HomeVM.ViewContents? { get }
    
    var setViewContents: PublishRelay<Void> { get }
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
        
        self.viewContents = ViewContents(weeklyConsumption: weeklyConsumption)
        
        setViewContents.accept(())
    }
    
    func touchWeeklyConsumption(_ index: Int) {
        guard let consumption = viewContents?.weeklyConsumption.weeklyConsumptionList[safe: index] else {
            return
        }
        
        print(consumption?.date.yearMonthDay())
    }
    
    //MARK: - Output
    struct ViewContents {
        let weeklyConsumption: WeeklyConsumption
    }
    var viewContents: HomeVM.ViewContents?
    let setViewContents = PublishRelay<Void>()
}
