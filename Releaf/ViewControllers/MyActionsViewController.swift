//
//  MyActionsViewController.swift
//  Releaf
//
//  Created by Batch-1 on 20/05/24.
//

import UIKit
import FirebaseAuth

class MyActionsViewController: UIViewController, UICollectionViewDataSource {
    
    var seeAllFor: String = ""
    let user = Auth.auth().currentUser
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return ReleafData.shared.getActions().count > 5 ? 5 : ReleafData.shared.getActions().count
        case 3:
            return 1
        case 4:
            return ReleafData.shared.getChallanges().count > 5 ? 5 : ReleafData.shared.getChallanges().count
        default:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Details", for: indexPath) as! DetailsCollectionViewCell
            
            if let userName = user?.displayName{
                cell.userNameLabel.text = "   \(userName.split(separator: " ")[0])"
            }
            
            let currentUser = ReleafData.shared.userData
            
            cell.completionLabel.text = "\(completionByUser)/\(completionMarkValue)"
            cell.ecoSphereLevelLabel.text = "\(currentUser.ecoSphereLevel)"
            cell.levelProgressBar.progress = Float(completionByUser) / Float(completionMarkValue)
            cell.rankLabel.text = "#\(currentUser.userRank)"
            cell.pointsLabel.text = "\(completionMarkValue - completionByUser) points"
            cell.offsetLabel.text = "\(currentUser.totalOffset)"
            cell.unitLabel.text = "\(WeightUnits.g)"
            cell.leaderboardButton.addTarget(self, action: #selector(leaderboardPressed), for: .touchUpInside)
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionsHeader", for: indexPath) as! ActionHeaderCollectionViewCell
            cell.seeAllActionButton.tag = 1
            cell.seeAllActionButton.addTarget(self, action: #selector(seeAllClicked), for: .touchUpInside)
            
            
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Action", for: indexPath) as! ActionCollectionViewCell
            cell.actionNameLabel.text = ReleafData.shared.getActions()[indexPath.row].name
            cell.actionDescriptionLabel.text = ReleafData.shared.getActions()[indexPath.row].description
            cell.singleActionView.layer.cornerRadius = 30
            cell.reducedLabel.text = "\(ReleafData.shared.getActions()[indexPath.row].amountReduced) \(ReleafData.shared.getActions()[indexPath.row].unit)"
            cell.rewardsLabel.text = "+\(ReleafData.shared.getActions()[indexPath.row].reward)"
            cell.seeInfoButton.tag = indexPath.row
            cell.seeInfoButton.addTarget(self, action: #selector(seeInfoClicked), for: .touchUpInside)
            
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengesHeader", for: indexPath) as! ChallengesHeaderCollectionViewCell
            cell.seeAllChallengesButton.tag = 2
            cell.seeAllChallengesButton.addTarget(self, action: #selector(seeAllClicked), for: .touchUpInside)
            
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Challenge", for: indexPath) as! ChallengeCollectionViewCell
            
//            let indexForChallenge = indexPath.row > ReleafData.challangesSection.count
            
            cell.challengeNameLabel.text = ReleafData.shared.getChallanges()[indexPath.row].name
            cell.challengeDescriptionLabel.text = ReleafData.shared.getChallanges()[indexPath.row].description
            cell.singleChallengeView.layer.cornerRadius = 30
            cell.reducedLabel.text = "\(ReleafData.shared.getChallanges()[indexPath.row].amountReduced)kg"
            cell.rewardsLabel.text = "+\(ReleafData.shared.getChallanges()[indexPath.row].reward)"
            cell.totalParticipantsLabel.text = "\(ReleafData.shared.getChallanges()[indexPath.row].numberOfParticipants)"
            
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionsHeader", for: indexPath)
            return cell
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    
    }
    
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = false
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? ""){
            userdata in
            if let _ = userdata{}
        }
        
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
                collectionView.addSubview(refreshControl)
        
        let actionNib = UINib(nibName: "Action", bundle: nil)
        let challengeNib = UINib(nibName: "Challenge", bundle: nil)
        let detailNib = UINib(nibName: "Details", bundle: nil)
        let actionHeaderNib = UINib(nibName: "ActionsHeader", bundle: nil)
        let challengesHeaderNib = UINib(nibName: "ChallengesHeader", bundle: nil)
        
        collectionView.register(actionNib, forCellWithReuseIdentifier: "Action")
        collectionView.register(challengeNib, forCellWithReuseIdentifier: "Challenge")
        collectionView.register(detailNib, forCellWithReuseIdentifier: "Details")
        collectionView.register(actionHeaderNib, forCellWithReuseIdentifier: "ActionsHeader")
        collectionView.register(challengesHeaderNib, forCellWithReuseIdentifier: "ChallengesHeader")
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        collectionView.dataSource = self
    }
    
    var isOpen = true
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section,env)-> NSCollectionLayoutSection? in
            
            switch section{
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(212))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
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
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
                    section.interGroupSpacing = 10
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
            case 4:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
                    section.interGroupSpacing = 10
            
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
    
    
    @objc func leaderboardPressed(){
        let vc = LeaderboardViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func seeAllClicked(_ sender: UIButton){
        
        if sender.tag == 1{
            seeAllFor = "Action"
        }
        else if sender.tag == 2{
            seeAllFor = "Challenge"
        }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AllACViewController") as! AllACViewController
        viewController.seeAllContextName = seeAllFor
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    @objc func seeInfoClicked(_ sender: UIButton){
        
        let tappedAction = ReleafData.shared.getActions()[sender.tag]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ACInfoViewController") as! ACInfoViewController
        viewController.actionData = tappedAction
        viewController.modalPresentationStyle = .pageSheet // or .pageSheet, .formSheet, etc.
        present(viewController, animated: true, completion: collectionView.reloadData )
    }
    
    @objc func refreshData(_ sender: Any) {
            // Perform your data loading and refresh here
            // For example, reload the collection view data
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? ""){
            userdata in
        }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    
    
    @IBAction func unwindSegueToAction(segue: UIStoryboardSegue){
        
    }
}
