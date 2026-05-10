//
//  NewProfileViewController.swift
//  Releaf
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit
import FirebaseAuth

class NewProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileOptions: [String] = ["Edit Profile", "Leaderboard", "Log Out", "Terms of use"]
    
    struct ProfileOptions {
        let title : String
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileOptions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = profileOptions[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if profileOptions[indexPath.row].lowercased() == "log out"{
            dismiss(animated: true){
                try? Auth.auth().signOut()
                self.goToLogoutScreen()
//                navigationController?.pushViewController(vc ?? self, animated: true)
            }
        }
    }
    
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var badgesCard: UIView!
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "alwaysbg")
           backgroundImage.contentMode = .scaleAspectFill
        userName.text = ReleafData.shared.userData.name
           
           self.view.addSubview(backgroundImage)
           
           self.view.sendSubviewToBack(backgroundImage)
       profilePic.translatesAutoresizingMaskIntoConstraints = true
        
        userName.textColor = .myDarkGreen
        badgesCard.backgroundColor = .seaGreen
        badgesCard.layer.cornerRadius = 13
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    func goToLogoutScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "first")
        navigationController?.pushViewController(vc, animated: true)
    }
}
