//
//  CarbonLogViewController.swift
//  Releaf
//
//  Created by Batch-2 on 27/05/24.
//

import UIKit
import FirebaseAuth

class CarbonLogViewController: UIViewController, UICollectionViewDataSource {
    
    
    
//    var user: User = Auth.auth().currentUser!
    var userData: ReleafUser = ReleafData.shared.userData
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if takenActions.isEmpty{
            return 4
        }
        else{
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
//            print("hello")
            return takenActions.count
        default:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LimitCard", for: indexPath) as! LimitCardCollectionViewCell
            
            cell.verticalProgressBar.progress = (Float(userData.currentCo2Value) / Float(userData.dailyLimit)) > 1 ? 1 : (Float(userData.currentCo2Value) / Float(userData.dailyLimit)) < 0 ? 0 : (Float(userData.currentCo2Value) / Float(userData.dailyLimit))
            print((Float(userData.currentCo2Value) / Float(userData.dailyLimit)))
            cell.dailyLimitLabel.text = "\(userData.dailyLimit)g"
            cell.fullMarkLabel.text = "---- \(userData.dailyLimit)"
            cell.halfMarkLabel.text = "\(userData.dailyLimit/2) ----"
            cell.percentageLabel.text = (Float(userData.currentCo2Value) / Float(userData.dailyLimit)) > 1 ? "100%" : (Float(userData.currentCo2Value) / Float(userData.dailyLimit)) < 0 ? "0%" : "\(Int((Float(userData.currentCo2Value) / Float(userData.dailyLimit)) * 100))%"
            cell.todayEmmisionLabel.text = "\(userData.currentCo2Value)g"
            if userData.currentCo2Value > userData.dailyLimit - userData.dailyLimit * (90/100){
                cell.todayEmmisionLabel.textColor = .red
            }
            else{
                cell.todayEmmisionLabel.textColor = .black
            }
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Streaks", for: indexPath) as! StreakCollectionViewCell
            cell.streakLabel.text = "\(ReleafData.shared.userData.streak)"
            cell.totalTreesPlantedLabel.text = "\(ReleafData.shared.userData.totalTreePlanted)"
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionsHeader", for: indexPath) as! ActionHeaderCollectionViewCell
            cell.seeAllActionButton.isHidden = true
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM"

            let todayDate = Date()
            let formattedDate = dateFormatter.string(from: todayDate)
            
            cell.headerLabel.text = "Today, \(formattedDate)"
            cell.headerLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddData", for: indexPath) as! AddDataCollectionViewCell
            
            cell.addFoodButton.tag = 0
            cell.addTravelButton.tag = 1
            cell.addElectricityButton.tag = 2
            
            cell.addFoodButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
            cell.addTravelButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
            cell.addElectricityButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
            
            
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionsHeader", for: indexPath) as! ActionHeaderCollectionViewCell
            cell.seeAllActionButton.isHidden = true
            cell.headerLabel.text = "Ongoing Actions"
            
            cell.headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
            
            
            return cell
            
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Action", for: indexPath) as! ActionCollectionViewCell
            print(takenActions)
            print("indexpath",indexPath.row)
            if !takenActions.isEmpty{
                cell.actionNameLabel.text = takenActions[indexPath.row].name
                cell.actionDescriptionLabel.text = takenActions[indexPath.row].description
                cell.singleActionView.layer.cornerRadius = 30
                cell.reducedLabel.text = "\(takenActions[indexPath.row].amountReduced) \(ReleafData.shared.getActions()[indexPath.row].unit)"
                cell.rewardsLabel.text = "+\(takenActions[indexPath.row].reward)"
                cell.seeInfoButton.tag = indexPath.row
                cell.seeInfoButton.addTarget(self, action: #selector(seeInfoClicked), for: .touchUpInside)
            }
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LimitCard", for: indexPath) as! LimitCardCollectionViewCell
            
//            cell.verticalProgressBar.progress = 0.5
            
            return cell
        }
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "") { userData in
            if let userData = userData {
                self.userData = userData
                self.collectionView.reloadData()
            } else {
            }
        }
//        userData = ReleafData.shared.userData
        
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "alwaysbg")
        
        collectionView.addSubview(backImageView)
        collectionView.sendSubviewToBack(backImageView)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
                collectionView.addSubview(refreshControl)
        
        let limitCardNib = UINib(nibName: "LimitCard", bundle: nil)
        let addDataNib = UINib(nibName: "AddData", bundle: nil)
        let headerNib = UINib(nibName: "ActionsHeader", bundle: nil)
        let actionsNib = UINib(nibName: "Action", bundle: nil)
        let streakNib = UINib(nibName: "Streaks", bundle: nil)
        
        collectionView.register(limitCardNib, forCellWithReuseIdentifier: "LimitCard")
        collectionView.register(addDataNib, forCellWithReuseIdentifier: "AddData")
        collectionView.register(headerNib, forCellWithReuseIdentifier: "ActionsHeader")
        collectionView.register(actionsNib, forCellWithReuseIdentifier: "Action")
        collectionView.register(streakNib, forCellWithReuseIdentifier: "Streaks")
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)

        collectionView.dataSource = self
    }
    
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (section,env)-> NSCollectionLayoutSection? in
            
            switch section{
            case 0:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(210))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 15, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
                
            case 1:
                
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
//                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
                
            case 2:
                
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
//                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
                
            case 3:
                
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(370))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 10, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
                
            case 4:
                
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
//                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
                
            case 5:
                
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 20, trailing: 10)
                    section.interGroupSpacing = 18
            
                section.orthogonalScrollingBehavior = .groupPagingCentered
            
                return section
                
                
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(38))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 18
                
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                
                return section
            }
        }
        return layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "") { userData in
            if let userData = userData {
                self.userData = userData
                self.collectionView.reloadData()
            } else {
            }
        }
        collectionView.reloadData()
    }
    
    
    @objc func refreshData(_ sender: Any) {
            // Perform your data loading and refresh here
            // For example, reload the collection view data
//            let sectionsToReload = IndexSet(arrayLiteral: 4)
        print("\(stateOfTakenAction)")
//        if stateOfTakenAction == .add && !takenActions.isEmpty{
////            print("add")
//            collectionView.reloadData()
//            collectionView.reloadSections(IndexSet(integer: 4))
//        }
//        else if stateOfTakenAction == .delete{
////            print("delete")
//            collectionView.reloadSections(IndexSet(integer: 4))
//            collectionView.reloadData()
//        }
        
//        let _ = ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "")
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "") { userData in
            if let userData = userData {
                self.userData = userData
                self.collectionView.reloadData()
            } else {
            }
        }
        collectionView.reloadData()
//        userData = ReleafData.shared.userData
            
            refreshControl.endRefreshing()
        }
    
    @objc func addData(sender: UIButton){
        switch sender.tag{
        case 0:
            
            let electrictyStoryboard = UIStoryboard(name: "AddFoodData", bundle: nil)
            if let modalVC = electrictyStoryboard.instantiateViewController(withIdentifier: "food") as?  AddFoodDataViewController{
                        modalVC.modalPresentationStyle = .pageSheet
                
                if let sheet = modalVC.sheetPresentationController {
                                            if #available(iOS 16.0, *) {
                                                let customDetent = UISheetPresentationController.Detent.custom { context in
                                                    return 350
                                                }
                                                sheet.detents = [customDetent]
                                            } else {
                                                // Fallback on earlier versions
                                            }
                
                                        }
                        present(modalVC, animated: true, completion: nil)
                    }
            
            
        case 1:
            if let modalVC = storyboard?.instantiateViewController(withIdentifier: "AddTravel") {
                        modalVC.modalPresentationStyle = .pageSheet
//                        if let sheet = modalVC.sheetPresentationController {
//                            if #available(iOS 16.0, *) {
//                                let customDetent = UISheetPresentationController.Detent.custom { context in
//                                    return 600
//                                }
//                                sheet.detents = [customDetent]
//                            } else {
//                                // Fallback on earlier versions
//                            }
//                            
//                        }
                if let sheet = modalVC.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                        present(modalVC, animated: true, completion: nil)
                }
        case 2:
            let electrictyStoryboard = UIStoryboard(name: "AddElectricityDetail", bundle: nil)
            if let modalVC = electrictyStoryboard.instantiateViewController(withIdentifier: "electricity") as?  AddElectricityDataViewController{
                        modalVC.modalPresentationStyle = .pageSheet
                
                if let sheet = modalVC.sheetPresentationController {
                    if #available(iOS 16.0, *) {
                                                let customDetent = UISheetPresentationController.Detent.custom { context in
                                                    return 300
                                                }
                                                sheet.detents = [customDetent]
                                            } else {
                                            }
                                        }
                
                
//                        if let sheet = modalVC.sheetPresentationController {
//                            sheet.detents = [.medium()]
//                        }
                        present(modalVC, animated: true, completion: nil)
                    }
            
        default:
            print("")
        }
    }
    
    @objc func seeInfoClicked(_ sender: UIButton){
        
        let tappedAction = takenActions[sender.tag]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ACInfoViewController") as! ACInfoViewController
        viewController.actionData = tappedAction
        viewController.parentVC = self
        
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true, completion: collectionView.reloadData )
    }
    
}


extension CarbonLogViewController: ACInfoViewControllerDelegateProtocol{
    func updateOngoingActionsView() {
        
        collectionView.reloadData()
    }
    

}
