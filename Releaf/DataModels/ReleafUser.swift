//
//  ReleafUser.swift
//  Releaf
//
//  Created by Skand on 25/05/24.
//

import Foundation

struct ReleafUser {
    var name: String?
    var dailyLimit: Int
    var currentCo2Value: Int
    let vehicle: [Vehicle]
    var totalTreePlanted: Int
    var virtualCurrency: Int
    var userRank: Int
    var ecoSphereLevel: Int
    var totalOffset: Int
    var streak: Int
    var country: String?
    var diet: String?
    var documentID: String?
}
