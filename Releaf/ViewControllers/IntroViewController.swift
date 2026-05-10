//
//  IntroViewController.swift
//  Releaf
//
//  Created by Batch-1 on 31/05/24.
//

import UIKit
import FirebaseAuth

class IntroViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    

        var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "alwaysbg")
           backgroundImage.contentMode = .scaleAspectFill
           
           self.view.addSubview(backgroundImage)
           
           self.view.sendSubviewToBack(backgroundImage)
        descriptionTitleLabel.textColor = .myDarkGreen
        descriptionLabel.textColor = .myDarkGreen

        updateContent()
        pageControl.numberOfPages = ReleafData.shared.images.count
                pageControl.currentPage = currentIndex
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if currentIndex == 2{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "onboard") as! AddDetailTableViewController
            vc.user = Auth.auth().currentUser
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            currentIndex += 1
            if currentIndex >= ReleafData.shared.images.count {
                        currentIndex = 0 // or handle the transition to the main part of the app
                    }
                    updateContent()
                    pageControl.currentPage = currentIndex
        }
        
    }
    func updateContent() {
        imageView.image = UIImage(named: ReleafData.shared.images[currentIndex])
        descriptionTitleLabel.text = ReleafData.shared.headings[currentIndex]
        descriptionLabel.text = ReleafData.shared.description[currentIndex]
        }
    
}
