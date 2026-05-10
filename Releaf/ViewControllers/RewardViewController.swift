//
//  RewardViewController.swift
//  Releaf
//
//  Created by Batch-2 on 28/05/24.
//

import UIKit

class RewardViewController: UIViewController {
    
    var reduced: Int = 0
    var reward: Int = 0

    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var reducedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rewardLabel.text = "+\(reward)"
        reducedLabel.text = "\(reduced)g"
        // Do any additional setup after loading the view.
    }
    
    func performRewardSegue() {
            // Dismiss the current view controller
            dismiss(animated: true) {
                // After dismissal, perform the new segue modally
                self.performSegue(withIdentifier: "rewardSegue", sender: nil)
            }
        }

}
