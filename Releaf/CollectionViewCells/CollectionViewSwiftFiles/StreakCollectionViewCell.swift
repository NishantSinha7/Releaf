//
//  StreakCollectionViewCell.swift
//  Releaf
//
//  Created by Batch-2 on 10/06/24.
//

import UIKit

class StreakCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var streaksView: UIView!
    
    @IBOutlet weak var totalTreesPlantedLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var totalActionsTakenView: UIView!
    
    @IBOutlet weak var treeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        streaksView.layer.cornerRadius = 20
        totalActionsTakenView.layer.cornerRadius = 20
        treeImageView.layer.cornerRadius = 20
    }
}
