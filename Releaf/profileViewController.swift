//
//  profileViewController.swift
//  Releaf
//
//  Created by Batch-1 on 20/05/24.
//

import UIKit

class profileViewController: UIViewController {


    @IBOutlet var progressDataView: [UIView]!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var menuListView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for eachView in progressDataView{
            eachView.layer.cornerRadius = 20
            eachView.backgroundColor = .seaGreen
        }
        
        profilePicture.layer.cornerRadius = 88
        profilePicture.translatesAutoresizingMaskIntoConstraints = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "alwaysbg")
           backgroundImage.contentMode = .scaleAspectFill
           
           self.view.addSubview(backgroundImage)
           
           self.view.sendSubviewToBack(backgroundImage)
       
        
        menuListView.layer.cornerRadius = 30
        menuListView.backgroundColor = .seaGreen
        

        
    }

}
