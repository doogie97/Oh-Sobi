//
//  HomeVM.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

import Foundation

protocol HomeVMable: HomeVMInput, HomeVMOutput {}

protocol HomeVMInput {
    func getMonthlyConsumption()
}

protocol HomeVMOutput {}

final class HomeVM: HomeVMable {
    private let getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase
    
    init(getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase) {
        self.getMonthlyConsumptionUseCase = getMonthlyConsumptionUseCase
    }
    
    func getMonthlyConsumption() {
        let date = Date()

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let year = components.year,
              let month = components.month else {
            debugPrint("월간 소비 호출 에러")
            return
        }
        let monthlyConsumption = getMonthlyConsumptionUseCase.execute(year: year, month: month)
        
        print(monthlyConsumption)
    }
}
