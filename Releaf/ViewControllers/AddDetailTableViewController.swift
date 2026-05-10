//
//  AddDetailTableViewController.swift
//  Releaf
//
//  Created by Batch-2 on 29/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddDetailTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dietSelectSwitch: UISwitch!
    @IBOutlet var vehicleButtons: [UIButton]!
    @IBOutlet var fuelButtons: [UIButton]!
    var user: User!
    var selectedCountry: String!
    @IBOutlet weak var vehicleStepper: UIStepper!
    @IBOutlet weak var noOfVehiclesLabel: UILabel!
    var noOfVehichles = 0
    var countriesName: [String] = []
    let db = Firestore.firestore()
    let initialUserData: [String: Any] = ["name": "", "dailyLimit": 0, "currentCo2Value": 0, "totalTreePlanted": 0, "virtualCurrency": 0, "userRank": 0, "ecoSphereLevel": 0, "totalOffset": 0, "streak": 0, "country": "", "diet": ""]
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countriesName[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            countryLabel.text = "Selected Country: \(countriesName[row])"
            selectedCountry = countriesName[row]
        }
        
    }
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        
        nameTextField.text = user.displayName ?? ""
        
        for index in 0..<6{
        setupVehicleButtons(with: index)
        setupFuelCarButtons(with: index)
        }
        
        dietSelectSwitch.isOn = false
        
        dietSelectSwitch.tintColor = UIColor.green
        dietSelectSwitch.layer.cornerRadius = dietSelectSwitch.frame.height / 2
        dietSelectSwitch.backgroundColor = dietSelectSwitch.tintColor
        
        vehicleStepper.maximumValue = 6
        
        for country in countries.keys{
            countriesName.append(country)
        }
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return noOfVehichles + 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1{
            return 120
        }
        else{
            return 60
        }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }

    @IBAction func vehicleStepperChanged(_ sender: UIStepper) {
        
        if !(sender.value > 6) {
            noOfVehiclesLabel.text = "\(Int(sender.value))"
            noOfVehichles = Int(sender.value)
            self.tableView.reloadData()
        }
    }
    
    func setupVehicleButtons(with index: Int) {
                
        vehicleButtons[index].menu = UIMenu(children: [
            UIAction(title: ReleafData.shared.vehiclesName[0], handler: {action in
                
                self.vehicleButtons[index].setTitle(action.title, for: .normal)
                if action.title == "2-Wheelers"{
                    self.setupFuel2WheelerButtons(with: index)
                }
                else{
                    self.setupFuelCarButtons(with: index)
                }
            }),
            UIAction(title: ReleafData.shared.vehiclesName[1], handler: {action in
                self.vehicleButtons[index].setTitle(action.title, for: .normal)
                if action.title == "2-Wheelers"{
                    self.setupFuel2WheelerButtons(with: index)
                }
                else{
                    self.setupFuelCarButtons(with: index)
                }
            }),
            UIAction(title: ReleafData.shared.vehiclesName[2], handler: {action in
                self.vehicleButtons[index].setTitle(action.title, for: .normal)
                if action.title == "2-Wheelers"{
                    self.setupFuel2WheelerButtons(with: index)
                }
                else{
                    self.setupFuelCarButtons(with: index)
                }
            }),
            UIAction(title: ReleafData.shared.vehiclesName[3], handler: {action in
                self.vehicleButtons[index].setTitle(action.title, for: .normal)
                if action.title == "2-Wheelers"{
                    self.setupFuel2WheelerButtons(with: index)
                }
                else{
                    self.setupFuelCarButtons(with: index)
                }
            })
        ])
        vehicleButtons[index].showsMenuAsPrimaryAction = true
    }
    
    
    func setupFuelCarButtons(with index: Int) {
        
        fuelButtons[index].menu = UIMenu(
            children: [
            UIAction(title: ReleafData.shared.fuelTypeCar[0], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)
                
            }),
            UIAction(title: ReleafData.shared.fuelTypeCar[1], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)}),
            UIAction(title: ReleafData.shared.fuelTypeCar[2], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)
            }),
            UIAction(title: ReleafData.shared.fuelTypeCar[3], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)})
        ]
        )
        fuelButtons[index].showsMenuAsPrimaryAction = true
    }
    
    func setupFuel2WheelerButtons(with index: Int) {
        
        fuelButtons[index].menu = UIMenu(children: [
            UIAction(title: ReleafData.shared.fuelType2Wheeler[0], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)
            }),
            UIAction(title: ReleafData.shared.fuelType2Wheeler[1], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)}),
            UIAction(title: ReleafData.shared.fuelType2Wheeler[2], handler: {action in
                self.fuelButtons[index].setTitle(action.title, for: .normal)
            })
        ])
        fuelButtons[index].showsMenuAsPrimaryAction = true
    }
    
    @IBAction func dietSwitchChanged(_ sender: UISwitch) {
        sender.onTintColor = .red
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        addUserVehicle(with: Int(vehicleStepper.value))
        let name = nameTextField.text ?? ""
        let selectedCountry = selectedCountry
        let diet = dietSelectSwitch.isOn ? "Non-Veg" : "Veg"
//        let _ = ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "")
        
        self.db.collection("users").document((Auth.auth().currentUser?.email)!).setData(
            ["name": name, "dailyLimit": 4600, "currentCo2Value": 1000, "totalTreePlanted": 0, "virtualCurrency": 0, "userRank": 0, "ecoSphereLevel": 0, "totalOffset": 0, "streak": 0, "country": "India", "diet": diet]
            , merge: true)
        
        for index in 0..<userVehicles.count{
            self.db.collection("users").document((Auth.auth().currentUser?.email)!).collection("vehicles").document().setData(
                ["vehcileType": userVehicles[index].vehicleType!, "fuel": userVehicles[index].fuel!]
            )
        }
    }
    
    func addUserVehicle(with count: Int){
        for index in 0..<count{
            let vehicle = Vehicle(vehicleType: vehicleButtons[index].titleLabel?.text, fuel: fuelButtons[index].titleLabel?.text)
            userVehicles.append(vehicle)
        }
        print(userVehicles)
    }
    
}
