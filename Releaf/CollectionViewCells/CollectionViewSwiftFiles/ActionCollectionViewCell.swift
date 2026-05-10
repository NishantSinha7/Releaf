//
//  ActionCollectionViewCell.swift
//  Releaf
//
//  Created by Batch-2 on 24/05/24.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actionNameLabel: UILabel!
    @IBOutlet weak var reducedCOView: UIView!
    @IBOutlet weak var actionDescriptionLabel: UILabel!
    @IBOutlet weak var singleActionView: UIView!
    @IBOutlet weak var reducedLabel: UILabel!
    @IBOutlet weak var rewardsLabel: UILabel!
    @IBOutlet weak var rewardsView: UIView!
    @IBOutlet weak var seeInfoButton: UIButton!
    
    @IBOutlet weak var actionBG: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        reducedCOView?.layer.cornerRadius = 20
        rewardsView?.layer.cornerRadius = 20
        
        actionBG.layer.cornerRadius = 20
        actionBG.layer.borderWidth = 1
        actionBG.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
    }

}
