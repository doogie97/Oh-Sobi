//
//  Repositoryable.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/13/24.
//

protocol Repositoryable {
    func getMontlyConsumption(year: Int, month: Int) -> MontlyConsumptionDTO
}
