//
//  LeaderboardViewController.swift
//  Releaf
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class LeaderboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 97
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRanks", for: indexPath)
            return cell
        
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestRanks", for: indexPath)
            return cell
        
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRanks", for: indexPath)
            return cell
        }
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leaderboardImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
    }


}
