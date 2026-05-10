//
//  Action.swift
//  Releaf
//
//  Created by Batch-2 on 07/06/24.
//

import Foundation

var actionCategories = ["Stay Healthy", "Get Festive", "Save Money", "Nature", "Save Electricity"]

enum Levels{
    case easy, medium, hard
}


struct Action: Equatable {
    let name: String
    let description: String
    let reward: Int
    let amountReduced: Int
    let image: String
    let level: Levels
    let unit: WeightUnits
    var documentID: String
}
