//
//  Container.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

protocol Containerable {
    func mainVC() -> MainVC
}

struct Container: Containerable {
    static let shared: Containerable = Container()
    private init() {}
    
    func mainVC() -> MainVC {
        return MainVC()
    }
}
