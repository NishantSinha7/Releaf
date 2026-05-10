//
//  CategoryCollectionViewCell.swift
//  Releaf
//
//  Created by Skand on 26/05/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryView.layer.cornerRadius = 18
        categoryView.layer.borderWidth = 1
        categoryView.layer.borderColor = UIColor(resource: .myDarkGreen).cgColor
    }
    
    
}
