//
//  AllACViewController.swift
//  Releaf
//
//  Created by Skand on 26/05/24.
//

import UIKit

class AllACViewController: UIViewController, UICollectionViewDataSource {
    
    var seeAllContextName = ""
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            
            return actionCategories.count
        case 1:
            return 1
        case 2:
            if seeAllContextName == "Action"{
                return ReleafData.shared.getActions().count
            }
            else if seeAllContextName == "Challenge"{
                return ReleafData.shared.getChallanges().count
            }
            return 1
        default:
            return 1
            
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoryCollectionViewCell
            
            cell.categoryNameLabel.text = actionCategories[indexPath.row]
            
            return cell
        
        case 1:
            
            
            if seeAllContextName == "Action"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionsHeader", for: indexPath) as! ActionHeaderCollectionViewCell
                
                cell.seeAllActionButton.isHidden = true
                
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengesHeader", for: indexPath) as! ChallengesHeaderCollectionViewCell

                cell.seeAllChallengesButton.isHidden = true
                
                return cell
            }
            
        case 2:
            if seeAllContextName == "Action"{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Action", for: indexPath) as! ActionCollectionViewCell
                cell.actionNameLabel.text = ReleafData.shared.getActions()[indexPath.row].name
                cell.actionDescriptionLabel.text = ReleafData.shared.getActions()[indexPath.row].description
                cell.singleActionView.layer.cornerRadius = 30
                cell.reducedLabel.text = "\(ReleafData.shared.getActions()[indexPath.row].amountReduced) \(ReleafData.shared.getActions()[indexPath.row].unit)"
                cell.rewardsLabel.text = "+\(ReleafData.shared.getActions()[indexPath.row].reward)"
                cell.seeInfoButton.tag = indexPath.row
                cell.seeInfoButton.addTarget(self, action: #selector(seeInfoClicked), for: .touchUpInside)
                
                
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Challenge", for: indexPath) as! ChallengeCollectionViewCell
                cell.challengeNameLabel.text = ReleafData.shared.getChallanges()[indexPath.row].name
                cell.challengeDescriptionLabel.text = ReleafData.shared.getChallanges()[indexPath.row].description
                cell.singleChallengeView.layer.cornerRadius = 30
                cell.reducedLabel.text = "\(ReleafData.shared.getChallanges()[indexPath.row].amountReduced)kg"
                cell.rewardsLabel.text = "+\(ReleafData.shared.getChallanges()[indexPath.row].reward)"
                cell.totalParticipantsLabel.text = "\(ReleafData.shared.getChallanges()[indexPath.row].numberOfParticipants)"
                
                
                return cell
            }
            
            
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionsHeader", for: indexPath)
            
            return cell
            
        }
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var itemCount = 1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        if seeAllContextName == "Action"{
            itemCount = ReleafData.shared.getActions().count
            navigationItem.title = "All Actions"
        }
        else if seeAllContextName == "Challenge"{
            itemCount = ReleafData.shared.getChallanges().count
            navigationItem.title = "All Challenges"
        }
        
        let actionHeaderNib = UINib(nibName: "ActionsHeader", bundle: nil)
        let challengesHeaderNib = UINib(nibName: "ChallengesHeader", bundle: nil)
        let categoriesNib = UINib(nibName: "Categories", bundle: nil)
        
        let actionNib = UINib(nibName: "Action", bundle: nil)
        let challengeNib = UINib(nibName: "Challenge", bundle: nil)
        
        collectionView.register(actionNib, forCellWithReuseIdentifier: "Action")
        collectionView.register(challengeNib, forCellWithReuseIdentifier: "Challenge")
        collectionView.register(actionHeaderNib, forCellWithReuseIdentifier: "ActionsHeader")
        collectionView.register(challengesHeaderNib, forCellWithReuseIdentifier: "ChallengesHeader")
        collectionView.register(categoriesNib, forCellWithReuseIdentifier: "Categories")
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)

        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (section,env)-> NSCollectionLayoutSection? in
            
            switch section{
            case 0:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(38))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
            case 2:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(CGFloat((210 * self.itemCount))))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: self.itemCount)
                
                group.interItemSpacing = NSCollectionLayoutSpacing.fixed(14.0)
                
                let section = NSCollectionLayoutSection(group: group)
                
                
                
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
            }

                

        }
        return layout
    }
    
    @objc func categoryTapped(with category: String){
        print("Category Tapped")
    }
    
    @objc func seeInfoClicked(_ sender: UIButton){
        
        let tappedAction = ReleafData.shared.getActions()[sender.tag]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ACInfoViewController") as! ACInfoViewController
        viewController.actionData = tappedAction
        viewController.parentVC = self
        
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true, completion: collectionView.reloadData )
    }
    
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier == "showReward"{
            performSegue(withIdentifier: "reward", sender: nil)
        }
        
    }
    

}
