//
//  MonthlyConsumption.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/13/24.
//

import Foundation

struct MonthlyConsumption {
    let id = UUID()
    let year: Int
    let month: Int
    let spentAmount: Int
    let limitAmt: Int
    let remainAmt: Int
    let consumptionList: [DailyConsumption]
}
