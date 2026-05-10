//
//  FootLogViewController.swift
//  Releaf
//
//  Created by Batch-2 on 15/05/24.
//

import UIKit
import QuartzCore
import Foundation

class FootLogViewController: UIViewController {

    @IBOutlet weak var footprintCardView: UIView!
    
    @IBOutlet weak var inputDataCardView: UIView!
    @IBOutlet weak var timeSegmentControl: UISegmentedControl!
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var currentCarbonEmissionLabel: UILabel!
    @IBOutlet weak var ongoingActionsView: UIView!
    
    @IBOutlet weak var limitLabel: UILabel!
    var progress: Double = 67/200
    
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProgress(progress: progress)
        
        whiteView.layer.cornerRadius = 70
        timeSegmentControl.insertSegment(withTitle: "Month", at: 2, animated: true)
        
        inputDataCardView.layer.cornerRadius = 13
        inputDataCardView.layer.borderWidth = 2
        
        ongoingActionsView.layer.cornerRadius = 13
        ongoingActionsView.layer.borderWidth = 2
        
        let meatlessBackgroundImage = UIImageView(frame: ongoingActionsView.bounds)
        meatlessBackgroundImage.image = UIImage(named: "meatless_bg")
        meatlessBackgroundImage.contentMode = .scaleToFill
           
        ongoingActionsView.addSubview(meatlessBackgroundImage)
           
           ongoingActionsView.sendSubviewToBack(meatlessBackgroundImage)
        
        footprintCardView.sendSubviewToBack(whiteView)

        
        footprintCardView.layer.cornerRadius = 13
        footprintCardView.backgroundColor = .seaGreen
        
        navigationController?.navigationBar.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "alwaysbg")
           backgroundImage.contentMode = .scaleAspectFill
           
           self.view.addSubview(backgroundImage)
           
           self.view.sendSubviewToBack(backgroundImage)
    }
    

    @IBAction func onTimeSegmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            currentCarbonEmissionLabel.text = "67g"
            limitLabel.text = "of 200g"
            updateProgress(progress: 67/200)
        }
        else if sender.selectedSegmentIndex ==  1{
            currentCarbonEmissionLabel.text = "820g"
            limitLabel.text = "of 1.4kg"
            updateProgress(progress: 82/140)
        }
        else{
            currentCarbonEmissionLabel.text = "15kg"
            limitLabel.text = "of 20kg"
            updateProgress(progress: 15 / 20 )
        }
        
    }
    
    func updateProgress(progress: Double){
        let shapeLayer = CAShapeLayer()
                shapeLayer.position.x = 0
                shapeLayer.position.y = -150
                let circularPath1 = UIBezierPath(arcCenter: view.center, radius: 80, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
                let trackLayer = CAShapeLayer()
                trackLayer.position.x = 0
                trackLayer.position.y = -150
                trackLayer.path = circularPath1.cgPath
                view.layer.addSublayer(trackLayer)
        trackLayer.strokeColor = UIColor(resource: .lightYellow).cgColor
                trackLayer.fillColor = UIColor.clear.cgColor
                trackLayer.lineWidth = 20
                
        let circularPath2 = UIBezierPath(arcCenter: view.center, radius: 80, startAngle: -CGFloat.pi / 2, endAngle: 4.7, clockwise: true)
                
                shapeLayer.path = circularPath2.cgPath
        shapeLayer.strokeEnd = 0.8
                
                view.layer.addSublayer(shapeLayer)
                
        shapeLayer.strokeColor = UIColor(resource: .myDarkGreen).cgColor
                shapeLayer.strokeEnd = 0
                shapeLayer.lineWidth = 20
                shapeLayer.fillColor = UIColor.clear.cgColor
                shapeLayer.lineCap = .round
                
        basicAnimation.toValue = progress
        basicAnimation.duration = 0.7
                basicAnimation.fillMode = .forwards
                basicAnimation.isRemovedOnCompletion = false
                shapeLayer.add(basicAnimation, forKey: "urBasic")
    }
    
}
