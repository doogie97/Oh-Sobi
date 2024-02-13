//
//  MontlyConsumptionDTO.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/13/24.
//

import Foundation

struct MontlyConsumptionDTO { //일단은 DTO라고 했으나 추후 로컬 저장소에 저장된 객체로 변경될 예정
    let year: Int
    let month: Int
    let limitAmount: Int
    let dailyConsumptionList: [DailyConsumptionDTO]
}
