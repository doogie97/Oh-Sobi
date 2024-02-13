//
//  Container.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

protocol Containerable {
    func homeVC() -> HomeVC
}

final class Container: Containerable {
    static let shared: Containerable = Container()
    private init() {}
    private let localStorageManager = LocalStorageManager()
    
    func homeVC() -> HomeVC {
        return HomeVC(viewModel: HomeVM(getMonthlyConsumptionUseCase: GetMonthlyConsumptionUseCase(localStorage: localStorageManager)))
    }
}
