//
//  DataInputViewController.swift
//  Releaf
//
//  Created by Batch-2 on 20/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddTravelDataViewController: UIViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    var x = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var addMyVehiclesButton: UIButton!
    @IBOutlet weak var addOtherModeButton: UIButton!
    var selectedMyVehicle = ""
    var selectedOtherMode = ""
    var emmision = 0
    var distance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabelPosition()
        setupMyVehicleButton(with: addMyVehiclesButton)
        setupOtherModeButton(with: addOtherModeButton)
        let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.addSubview(blurEffectView)
                view.sendSubviewToBack(blurEffectView)

    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func distanceSliderValueChanged(_ sender: UISlider) {
        
        
//        if(Int(sender.value) < distance){
//            distanceLabel.layer.position.x -= CGFloat(sender.value )
//        }
//        else{
//            distanceLabel.layer.position.x += CGFloat(sender.value )
//        }
        updateLabelPosition()
        distanceLabel.text = "\(Int(sender.value))km"
        distance = Int(sender.value)
        
    }
    
    
    @IBAction func selectMyVehicleButtonTapped(_ sender: UIButton) {
        setupMyVehicleButton(with: sender)
        }
    
    @IBAction func selectOtherModeButtonTapped(_ sender: UIButton) {
        setupOtherModeButton(with: sender)
    }
    
    func setupMyVehicleButton(with sender: UIButton){
        sender.menu = UIMenu(
            children: ReleafData.shared.userData.vehicle.map { vehicle in
                UIAction(title: "\(vehicle.vehicleType!) (\(vehicle.fuel!))", handler: { action in
                    sender.setTitle(action.title, for: .normal)
                    self.addOtherModeButton.setTitle("Others", for: .normal)
                    self.addOtherModeButton.tintColor = .systemBlue
                    self.addMyVehiclesButton.tintColor = .myDarkGreen
                    self.selectedMyVehicle = ""
                    self.emmision = 107
                })
            }
        )
        sender.showsMenuAsPrimaryAction = true

    }
    
    
    func setupOtherModeButton(with sender: UIButton){
        sender.menu = UIMenu(children: otherModesNames.map{
            mode,emmision in
            UIAction(title: mode, handler: { action in
                sender.setTitle(action.title, for: .normal)
                self.selectedOtherMode = mode
                self.addMyVehiclesButton.setTitle("Select from My Vehicle", for: .normal)
                self.addMyVehiclesButton.tintColor = .systemBlue
                self.addOtherModeButton.tintColor = .myDarkGreen
                self.selectedMyVehicle = ""
                self.emmision = emmision
            })
        }
        )
        sender.showsMenuAsPrimaryAction = true

    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if distance != 0{
            emmision *= distance
//            currentUser.currentCo2Value += emmision
            
            updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCo2Value: (ReleafData.shared.userData.currentCo2Value) + emmision)
            dismiss(animated: true)
        }
    }
    
    
    private func updateLabelPosition() {
            let sliderTrack: CGRect = slider.trackRect(forBounds: slider.bounds)
            let sliderThumb: CGRect = slider.thumbRect(forBounds: slider.bounds, trackRect: sliderTrack, value: slider.value + 10)
            
        distanceLabel.center = CGPoint(x: sliderThumb.midX, y: slider.frame.minY - 20)
        }
    
    
    
    func updateUserData(with emailID: String, updatedCo2Value: Int) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(emailID)
        
        userRef.updateData([
            "currentCo2Value": updatedCo2Value
        ]) { error in
            if let error = error {
                print("Error updating user data: \(error)")
            } else {
                print("User data updated successfully")
            }
        }
    }
}
