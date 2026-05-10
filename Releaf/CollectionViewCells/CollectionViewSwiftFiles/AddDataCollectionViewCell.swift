//
//  AddDataCollectionViewCell.swift
//  Releaf
//
//  Created by Batch-2 on 27/05/24.
//

import UIKit

class AddDataCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addDataView: UIView!
    
    @IBOutlet weak var singleAddView: UIView!
    
    @IBOutlet weak var shopAddView: UIView!
    @IBOutlet weak var travelAddView: UIView!
    
    
    @IBOutlet weak var addFoodButton: UIButton!
    
    @IBOutlet weak var addTravelButton: UIButton!
    
    @IBOutlet weak var addElectricityButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addDataView.layer.cornerRadius = 25
        singleAddView.layer.cornerRadius = 25
        shopAddView.layer.cornerRadius = 25
        travelAddView.layer.cornerRadius = 25
    }
}
