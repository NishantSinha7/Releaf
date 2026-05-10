//
//  ViewController.swift
//  Releaf
//
//  Created by Batch-2 on 10/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor(resource: .myGreen).cgColor, UIColor(resource: .myGreen).cgColor,]
        gradient.startPoint = CGPoint(x: 1, y: 0)
//        logoImageView.layer.cornerRadius = 70

        view.layer.insertSublayer(gradient, at: 0)
        
    }
    

}

