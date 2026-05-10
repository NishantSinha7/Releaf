//
//  UserOnboardingViewController.swift
//  Releaf
//
//  Created by Batch-2 on 14/05/24.
//

import UIKit

class UserOnboardingViewController: UIViewController {

    @IBOutlet weak var calloutView: UIView!
    @IBOutlet weak var calloutView2: UIView!
    @IBOutlet var capsuleImageView: [UIImageView]!
    var count = 0
    @IBOutlet weak var carbonEmissionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        navigationController?.navigationBar.isHidden = true
        calloutView.layer.borderWidth = 2
        
        let maskPath = UIBezierPath(roundedRect: calloutView.bounds,
                                        byRoundingCorners: [.topRight, .topLeft, .bottomRight],
                                        cornerRadii: CGSize(width: 20, height: 20))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            calloutView.layer.mask = maskLayer
            let borderLayer = CAShapeLayer()
            borderLayer.path = maskPath.cgPath
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.black.cgColor
            borderLayer.lineWidth = 3.5
            borderLayer.frame = calloutView.bounds
            calloutView.layer.addSublayer(borderLayer)
        
        
        
        
        
        
        
        
        
        
        
        
        calloutView2.layer.borderWidth = 2
        
        let maskPath2 = UIBezierPath(roundedRect: calloutView2.bounds,
                                        byRoundingCorners: [.topRight, .topLeft, .bottomRight],
                                        cornerRadii: CGSize(width: 20, height: 20))
            let maskLayer2 = CAShapeLayer()
            maskLayer2.path = maskPath2.cgPath
            calloutView2.layer.mask = maskLayer2
            let borderLayer2 = CAShapeLayer()
            borderLayer2.path = maskPath2.cgPath
            borderLayer2.fillColor = UIColor.clear.cgColor
            borderLayer2.strokeColor = UIColor.black.cgColor
            borderLayer2.lineWidth = 3.5
            borderLayer2.frame = calloutView2.bounds
            calloutView2.layer.addSublayer(borderLayer2)
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "alwaysbg")
           backgroundImage.contentMode = .scaleAspectFill
           
           self.view.addSubview(backgroundImage)
           
           self.view.sendSubviewToBack(backgroundImage)
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        count += 1
        if count <= 6{
            updateUI()
        }
        else{
            performSegue(withIdentifier: "homeSegue", sender: nil)
        }
        
        }

    
    func updateUI(){
        
        carbonEmissionLabel.text = "\((Double(carbonEmissionLabel.text!)!) + 2.33)"
        
        for i in 0...count{
                capsuleImageView[i].image = UIImage(resource: .capsuleFill)
        }
        
    }
}
