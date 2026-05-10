//
//  AddElectricityDataViewController.swift
//  Releaf
//
//  Created by Batch-1 on 04/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddElectricityDataViewController: UIViewController {

    @IBOutlet var yesTapped: UIButton!
    @IBOutlet var noTapped: UIButton!
    @IBOutlet var selectOptionsButton: UIButton!
    
     var selectedOption = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.addSubview(blurEffectView)
                view.sendSubviewToBack(blurEffectView)
        
        selectOptionsButton.isHidden = true
        selectDurationButton(with: selectOptionsButton)
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {

        selectOptionsButton.isHidden = false
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        
        selectOptionsButton.isHidden = true
        dismiss(animated: true)
    }
    
    @IBAction func selectOptionButtonTapped(_ sender: UIButton) {
        selectDurationButton(with: sender)
    }
//    let electricity: [String] = ["1 - 5 hr", "5 - 10 hr", "more than 10 hr"]
    
    func selectDurationButton(with sender: UIButton) {
        sender.menu = UIMenu (
                    children: electricity.map{
                        option in UIAction(title: option, handler: {
                            action in sender.setTitle(action.title, for: .normal)
                            self.selectedOption = option
                        })
                    }
        
        
                )
                sender.showsMenuAsPrimaryAction = true
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        if selectedOption != ""{
            if selectedOption == "1 - 5 Hr"{
                updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCo2Value: (ReleafData.shared.userData.currentCo2Value) + 500)
            }
            else if selectedOption == "5 - 10 Hr"{
                updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCo2Value: (ReleafData.shared.userData.currentCo2Value) + 2500)
            }
            else{
                updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCo2Value: (ReleafData.shared.userData.currentCo2Value) + 7000)
            }
            dismiss(animated: true)
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
    }
    
}
