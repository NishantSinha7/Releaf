//
//  ACInfoViewController.swift
//  Releaf
//
//  Created by Skand on 26/05/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol ACInfoViewControllerDelegateProtocol{
    func updateOngoingActionsView()
}

class ACInfoViewController: UIViewController {
    
    var delegate: ACInfoViewControllerDelegateProtocol?
    @IBOutlet weak var giveUpButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    var actionData: Action!
    @IBOutlet weak var actionNameLabel: UILabel!
    
    @IBOutlet weak var actionDetailsTextView: UITextView!
    @IBOutlet weak var actionRewardLabel: UILabel!
    @IBOutlet weak var actionReduceLabel: UILabel!
    @IBOutlet weak var actionLevelLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var actionImageView: UIImageView!
    
    var parentVC: UIViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionDetailsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)

        if let action = actionData{
            
            updateUI()
            
            if let imageURL = URL(string: action.image) {
                actionImageView.setImage(from: imageURL)
            }
            
            
            
            actionNameLabel.text = action.name
            actionDetailsTextView.text = action.description
            actionRewardLabel.text = "+\(action.reward)"
            actionLevelLabel.text = "\(action.level)"
            actionReduceLabel.text = "\(action.amountReduced)\(action.unit)"
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        
        let alertController = UIAlertController(title: "Start Challenge", message: "Do you want to start the challenge?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                    if let action = self.actionData{
                        takenActions.append(action)
                        stateOfTakenAction = .add
                        print("added")
                        self.delegate?.updateOngoingActionsView()
                    }
                    self.updateUI()
                }
                
                let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
                    print("Challenge not started.")
                }
                
                alertController.addAction(yesAction)
                alertController.addAction(noAction)
                
                present(alertController, animated: true, completion: nil)
        
    }
    
    
    func updateUI(){
        if let action = actionData{
            if takenActions.contains(action){
                startButton.isHidden = true
                completedButton.isHidden = false
                giveUpButton.isHidden = false
            }
            else{
                startButton.isHidden = false
                completedButton.isHidden = true
                giveUpButton.isHidden = true
            }
        }
    }
    
    
    
    @IBAction func completedButtonTapped(_ sender: UIButton) {
        var c = -1
        if let action = actionData{
            
//            currentUser.totalOffset += action.amountReduced
//            currentUser.virtualCurrency += action.reward
//            currentUser.currentCo2Value -= action.amountReduced
            
            
            
            for i in 0..<takenActions.count{
                if takenActions[i] == action{
                    c = i
                    updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCo2Value: (ReleafData.shared.userData.currentCo2Value) - action.amountReduced, totalOffset: (ReleafData.shared.userData.totalOffset) + action.amountReduced, currency: ReleafData.shared.userData.virtualCurrency + action.reward)
                    stateOfTakenAction = .delete
                    break
                }
            }
        }
        if c != -1{
            takenActions.remove(at: c)
            
            print("removed")
            self.delegate?.updateOngoingActionsView()
        }
        
        updateUI()
        print(takenActions.count)
        
        performSegue(withIdentifier: "rewardSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RewardViewController{
            vc.reduced = actionData.amountReduced
            vc.reward = actionData.reward
        }
            
    }
    
    
    func updateUserData(with emailID: String, updatedCo2Value: Int, totalOffset: Int, currency: Int) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(emailID)
        
        userRef.updateData([
            "currentCo2Value": updatedCo2Value,
            "totalOffset": totalOffset,
            "virtualCurrency": currency
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


extension UIImageView {
    func setImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

