
import UIKit

class LimitCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var verticalProgressBar: VerticalProgressView!
    
    @IBOutlet weak var dailyLimitLabel: UILabel!
    @IBOutlet weak var todayEmmisionLabel: UILabel!
    @IBOutlet weak var fullMarkLabel: UILabel!
    @IBOutlet weak var halfMarkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var limitCardView: UIView!
    @IBOutlet weak var progressBackView: VerticalProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressBackView.layer.cornerRadius = 20
        
        limitCardView.layer.cornerRadius = 20
        
        imageView.layer.cornerRadius = 20
    }
}
