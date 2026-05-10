//
//  ActionsData.swift
//  Releaf
//
//  Created by Batch-2 on 24/05/24.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore


class ReleafData {
    
    static let shared = ReleafData()
    private let db = Firestore.firestore()
    var actions = [Action]()
    var userVehicles = [Vehicle]()
    var i = 1
    
    private init(){}
    
    var userData: ReleafUser = ReleafUser(name: "name", dailyLimit: 1, currentCo2Value: 0, vehicle: [], totalTreePlanted: 1, virtualCurrency: 1, userRank: 1, ecoSphereLevel: 1, totalOffset: 1, streak: 1, country: "country", diet: "diet")
    
    
//     private var actionsSection: [Action] = [Action(name: "Meatless Tuesday", description: "Meatless Action", reward: 20, amountReduced: 30, image: "", level: .medium, unit: .g), Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Meatless Monday", description: "Meatless Action", reward: 20, amountReduced: 30, image: "", level: .medium, unit: .g), Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g),Action(name: "Go Green", description: "Green Action", reward: 40, amountReduced: 10, image: "", level: .easy, unit: .g)]
    
    
    
    
//    private var actionsSection: [Action] = [
//        Action(name: "Go Vegetarian", description: "Eliminate meat from your diet for a day to reduce your carbon footprint.", reward: 20, amountReduced: 2000, image: "https://shorturl.at/Ok9ZT", level: .medium, unit: .g),
//        Action(name: "Bike to Work", description: "Bike to work instead of driving for a day.", reward: 12, amountReduced: 1200, image: "https://shorturl.at/k7Owy", level: .hard, unit: .g),
//        Action(name: "No Plastic", description: "Avoid using any single-use plastic items for a day.", reward: 10, amountReduced: 1000, image: "https://rb.gy/w4gfhk", level: .medium, unit: .g),
//        Action(name: "Plant a Tree", description: "Plant a tree and help absorb CO2.", reward: 18, amountReduced: 1800, image: "https://rb.gy/0r50tn", level: .easy, unit: .g),
//        Action(name: "Cold Showers", description: "Take cold showers to save energy for a day.", reward: 8, amountReduced: 800, image: "https://rb.gy/6zfwrr", level: .hard, unit: .g),
//        Action(name: "Compost Organic Waste", description: "Start composting your organic waste for a day.", reward: 7, amountReduced: 700, image: "https://rb.gy/ezej5i", level: .easy, unit: .g),
//        Action(name: "Zero-Waste Shopping", description: "Shop without plastic packaging for a day.", reward: 8, amountReduced: 800, image: "https://rb.gy/lqknaj", level: .medium, unit: .g),
//        Action(name: "Use Public Transport", description: "Use public transport instead of personal vehicles for a day.", reward: 12, amountReduced: 1200, image: "https://t.ly/7QeUI", level: .easy, unit: .g),
//        Action(name: "Eco-Friendly Cooking", description: "Cook with energy-efficient methods for a day.", reward: 6, amountReduced: 600, image: "https://t.ly/OGkt_", level: .easy, unit: .g),
//        Action(name: "Upcycle Old Clothes", description: "Upcycle or repurpose old clothes.", reward: 4, amountReduced: 400, image: "https://t.ly/DNf3x", level: .medium, unit: .g),
//        Action(name: "Unplug Devices", description: "Unplug devices when not in use.", reward: 1, amountReduced: 100, image: "https://t.ly/MHnuG", level: .easy, unit: .g),
//        Action(name: "LED Bulbs", description: "Replace all bulbs with LED ones.", reward: 2, amountReduced: 250, image: "https://shorturl.at/AoQjo", level: .medium, unit: .g),
//        Action(name: "Carpooling", description: "Carpool with colleagues for a day.", reward: 14, amountReduced: 1400, image: "https://t.ly/b-NB3", level: .medium, unit: .g),
//        Action(name: "Paperless Week", description: "Avoid using paper for a day.", reward: 2, amountReduced: 200, image: "https://rb.gy/2m9uqu", level: .easy, unit: .g),
//        Action(name: "Smart Thermostat", description: "Install a smart thermostat to reduce energy use.", reward: 10, amountReduced: 1000, image: "https://rb.gy/8gkz4n", level: .hard, unit: .g),
//        Action(name: "Reusable Water Bottle", description: "Use a reusable water bottle.", reward: 1, amountReduced: 100, image: "https://rb.gy/c899vp", level: .easy, unit: .g),
//        Action(name: "Minimalist Wardrobe", description: "Adopt a minimalist wardrobe approach.", reward: 2, amountReduced: 200, image: "https://rb.gy/7kropa", level: .medium, unit: .g),
//        Action(name: "Solar Chargers", description: "Use solar chargers for your devices.", reward: 2, amountReduced: 200, image: "https://rb.gy/0tqmku", level: .medium, unit: .g),
//        Action(name: "DIY Cleaning Products", description: "Make your own eco-friendly cleaning products.", reward: 2, amountReduced: 150, image: "https://shorturl.at/XoUQP", level: .medium, unit: .g),
//        Action(name: "Sustainable Fashion", description: "Buy only sustainable fashion items for a day.", reward: 3, amountReduced: 300, image: "https://shorturl.at/6K78I", level: .hard, unit: .g)
//    ]


    
    
     private var challangesSection: [Challenge] = [Challenge(name: "Meatless Tuesday", description: "Get meatless for a day", reward: 30, amountReduced: 15, image: "", level: .hard, time: "1 Day", numberOfParticipants: 45, unit: .g),Challenge(name: "Hello", description: "Challenge", reward: 30, amountReduced: 15, image: "", level: .hard, time: "1 Day", numberOfParticipants: 63, unit: .g)]
    
    
     let vehiclesName: [String] = ["Car-Sedan", "Car-SUV", "Car-Hatchback", "2-Wheelers"]
     let fuelTypeCar: [String] = ["Petrol", "Diesel", "Electric", "CNG"]
     let fuelType2Wheeler: [String] = ["Petrol", "Electric", "Cycle"]
    
    
    
     let images = ["carbonLogIntro", "ecoSphereIntro", "actionIntro"]
     let headings = ["Carbon Log", "Eco Sphere", "My Actions"]
     let description = ["Welcome to Carbon Log, your personal environmental impact tracker. Monitor and record your daily carbon footprint with ease.", "Step into Eco Sphere, a vibrant virtual reality where your positive actions come to life.", "Discover My Actions, your gateway to impactful challenges and events.Every action you take contributes to a healthier planet."]
    
    
    
    
    func getActions() -> [Action]{
        
        let actionsRef = db.collection("actions")
        
        
        //
        
//        if i == 1{
//            for action in actionsSection {
//                let actionData: [String: Any] = [
//                            "name": action.name,
//                            "description": action.description,
//                            "reward": action.reward,
//                            "amountReduced": action.amountReduced,
//                            "level": "\(action.level)",
//                            "image": action.image,
//                            "unit": "\(action.unit)"
//                        ]
//
//                        // Add a new document with a generated ID
//                        actionsRef.addDocument(data: actionData) { error in
//                            if let error = error {
//                                print("Error adding action: \(error)")
//                            } else {
//                                print("Action added successfully!")
//                            }
//                        }
//            }
//            
//            i = 2
//        }
        
        
        
        
        
        
        //
        if i == 1{
            actionsRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching actions: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                
                for document in documents {
                    let data = document.data()
                    
                    if let name = data["name"] as? String,
                       let description = data["description"] as? String,
                       let reward = data["reward"] as? Int,
                       let amountReduced = data["amountReduced"] as? Int,
                       let level = data["level"] as? String,
                       let unit = data["unit"] as? String,
                    let image = data["image"] as? String
                    {
                        let documentID = document.documentID
                        let unitEnum: WeightUnits!
                        let levelEnum: Levels
                        
                        if unit.lowercased() == "g"{
                            unitEnum = .g
                        }
                        else{
                            unitEnum = .Kg
                        }
                        
                        
                        
                        switch level.lowercased(){
                        case "easy":
                            levelEnum = .easy
                        case "medium":
                            levelEnum = .medium
                        case "hard":
                            levelEnum = .hard
                        default:
                            levelEnum = .easy
                        }
                        
                        let action = Action(name: name, description: description, reward: reward, amountReduced: amountReduced, image: image, level: levelEnum, unit: unitEnum, documentID: documentID)
                        print(action)
                        self.actions.append(action)
                    }
                }
                
            }
             i = 2
        }
        
        
        return actions
    }
    
    func getChallanges() -> [Challenge]{
        
        return challangesSection
    }
    
    
    
    func getUserData(with emailID: String, completion: @escaping (ReleafUser?) -> Void) {
        let userRef = db.collection("users")
        var userVehicles = [Vehicle]()
        
        userRef.document(emailID).collection("vehicles").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching vehicles: \(error)")
                completion(nil)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No vehicle documents found")
                completion(nil)
                return
            }
            
            for document in documents {
                let data = document.data()
                if let vehicleName = data["vehcileType"] as? String,
                   let fuel = data["fuel"] as? String {
                    let vehicle = Vehicle(vehicleType: vehicleName, fuel: fuel)
                    userVehicles.append(vehicle)
                }
            }
            
            userRef.document(emailID).getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error fetching user data: \(error)")
                    completion(nil)
                    return
                }
                
                guard let data = documentSnapshot?.data() else {
                    print("No user data found")
                    completion(nil)
                    return
                }
                
                
                if let country = data["country"] as? String,
                   let currentCo2Value = data["currentCo2Value"] as? Int,
                   let dailyLimit = data["dailyLimit"] as? Int,
                   let diet = data["diet"] as? String,
                   let ecoSphereLevel = data["ecoSphereLevel"] as? Int,
                   let name = data["name"] as? String,
                   let streak = data["streak"] as? Int,
                   let totalOffset = data["totalOffset"] as? Int,
                   let totalTreePlanted = data["totalTreePlanted"] as? Int,
                   let userRank = data["userRank"] as? Int,
                   let virtualCurrency = data["virtualCurrency"] as? Int
                {
                    let userData = ReleafUser(name: name, dailyLimit: dailyLimit, currentCo2Value: currentCo2Value, vehicle: userVehicles, totalTreePlanted: totalTreePlanted, virtualCurrency: virtualCurrency, userRank: userRank, ecoSphereLevel: ecoSphereLevel, totalOffset: totalOffset, streak: streak, country: country, diet: diet)
//                    print(documentID)
                    
                    self.userData = userData
                    completion(userData)
                } else {
                    completion(nil)
                }
            }
        }
    }

    
    
    
}
