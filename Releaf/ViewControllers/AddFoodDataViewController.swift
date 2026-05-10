//
//  AddFoodDataViewController.swift
//  Releaf
//
//  Created by nimit kumar on 03/06/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddFoodDataViewController: UIViewController {

    @IBOutlet var vegButton: UIButton!
    
    @IBOutlet var nonvegButton: UIButton!
    @IBOutlet var selectFoodServiceButton: UIButton!
    
    var selectedOtherFood = "veg"
    
    var buttonTapped = true
    var selectedFoodType = ""
    var emmision = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.addSubview(blurEffectView)
                view.sendSubviewToBack(blurEffectView)
        
        setupMyOtherFoodOptions(with: selectFoodServiceButton)
        
    }
    

    
    
    @IBAction func OtherFoodOptions(_ sender: UIButton) {
        setupMyOtherFoodOptions(with: sender)
        
    }
    
    
    func setupMyOtherFoodOptions(with sender: UIButton){
        sender.menu = UIMenu(
            children: otherFoodNames.map{ (foodName, data) in
                UIAction(title: foodName, handler: {action in sender.setTitle(action.title, for: .normal)
                    self.selectedOtherFood = foodName
                    self.emmision = data[self.selectedFoodType]!
                })
            }
        )
        sender.showsMenuAsPrimaryAction = true
    }
    
    
    @IBAction func vegButtonClicked(_ sender: UIButton) {
        selectedFoodType = "veg"
        vegButton.tintColor = .myDarkGreen
        nonvegButton.tintColor = .systemBlue
    }
    
    
    @IBAction func nonVegButtonClicked(_ sender: UIButton) {
        selectedFoodType = "nonveg"
        nonvegButton.tintColor = .myDarkGreen
        vegButton.tintColor = .systemBlue
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if emmision != 0{
            dismiss(animated: true)
            updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCo2Value: (ReleafData.shared.userData.currentCo2Value) + emmision)
        }
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
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "") { userData in
            
        }
    }
}

