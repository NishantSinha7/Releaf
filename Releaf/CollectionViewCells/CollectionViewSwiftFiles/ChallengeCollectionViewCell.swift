//
//  ChallengeCollectionViewCell.swift
//  Releaf
//
//  Created by Skand on 26/05/24.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell {
    
//    actionNameLabel
//    actionDescriptionLabel
//    singleActionView
//    reducedLabel
//    rewardsLabel
    
    @IBOutlet weak var totalParticipantsLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    
    @IBOutlet weak var singleChallengeView: UIView!
    
    @IBOutlet weak var reducedLabel: UILabel!
    
    @IBOutlet weak var rewardsLabel: UILabel!
    
    @IBOutlet weak var reducedCOView: UIView!
    
    @IBOutlet weak var rewardsView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reducedCOView?.layer.cornerRadius = 20
        rewardsView?.layer.cornerRadius = 20
        
    }
    
}
