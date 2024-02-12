//
//  Container.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

protocol Containerable {
    func homeVC() -> HomeVC
}

struct Container: Containerable {
    static let shared: Containerable = Container()
    private init() {}
    
    func homeVC() -> HomeVC {
        return HomeVC(viewModel: HomeVM())
    }
}
