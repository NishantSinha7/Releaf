//
//  OngoingChallangeInfoViewController.swift
//  Releaf
//
//  Created by Batch-2 on 20/05/24.
//

import UIKit

class OngoingChallangeInfoViewController: UIViewController {

    @IBOutlet weak var giveUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giveUpButton.layer.borderWidth = 2
        giveUpButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
