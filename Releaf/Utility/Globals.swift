//
//  Globals.swift
//  Releaf
//
//  Created by Skand on 25/05/24.
//

import Foundation

enum Fuels{
    case petrol, diesel, cng, electric
}

enum StateOfTakenAction{
    case add, delete, neutral
}

var stateOfTakenAction: StateOfTakenAction = .neutral

var currentUser = ReleafUser(name: nil, dailyLimit: 2000, currentCo2Value: Int.random(in: 800...1000), vehicle: [Vehicle(vehicleType: "Car - Sedan", fuel: "Petrol")], totalTreePlanted: 200, virtualCurrency: 320, userRank: 12, ecoSphereLevel: 2, totalOffset: 430,streak: 15)

let totalEmissionPerDay = 4600

var takenActions: [Action] = []

var userVehicles: [Vehicle] = []
var otherModesNames: [String: Int] = ["Auto": 60, "Bus": 75, "E-Rickshaw": 20, "Cab - Sedan": 150, "Cab - Mini": 100, "Cab - SUV": 230, "Metro": 25]

let countries: [String:Int] = ["India": totalEmissionPerDay, "Luxemberg": totalEmissionPerDay, "United States": totalEmissionPerDay, "Japan": totalEmissionPerDay, "Sweden": totalEmissionPerDay, "France": totalEmissionPerDay, "China": totalEmissionPerDay, "Brazil": totalEmissionPerDay, "Ethiopia": totalEmissionPerDay]
// Food Input
var otherFoodNames: [String: [String: Int]] = ["Dineout":["veg":600,"nonveg":1000],"Processed Food":["veg":570,"nonveg":1000],"Food Delivery":["veg":625,"nonveg":1000], "Home-made":["veg":125,"nonveg":250]]

let electricity: [String] = ["1 - 5 Hr", "5 - 10 Hr", "more than 10 Hr"]

var completionMarkValue = 80
var completionByUser = 70

enum WeightUnits{
    case Kg, g
}
