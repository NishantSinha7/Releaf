//
//  DetailsCollectionViewCell.swift
//  Releaf
//
//  Created by Skand on 25/05/24.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var detailsCardView: UIView!
    
    @IBOutlet weak var ecoSphereLevelLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var levelProgressBar: UIProgressView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailsCardView?.layer.cornerRadius = 15
        detailsCardView?.backgroundColor = .seaGreen
        setupShadow()
    }
    
    
    func setupShadow() {

        // Configure the shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
        
        // Optional: Add a shadow path for better performance
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
