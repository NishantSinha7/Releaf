//
//  LogInViewController.swift
//  Releaf
//
//  Created by Batch-2 on 10/05/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore


class LogInViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    let db = Firestore.firestore()
    let authManager = AuthManager()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "Let's\nlog you in"

        // Do any additional setup after loading the view.
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor(resource: .myGreen).cgColor, UIColor(resource: .myGreen).cgColor,]
        gradient.startPoint = CGPoint(x: 1, y: 0)

        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    @IBAction func gmailSignInButtonTapped(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { 
            [] result, error in
          guard error == nil else {
            return
          }
            
            guard let user = result?.user,
                let idToken = user.idToken?.tokenString
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in

                self.authManager.checkFirstLogin { isFirstLogin in
                       if isFirstLogin {
//                           self.performSegue(withIdentifier: "logged", sender: Auth.auth().currentUser)
                           let storyboard = UIStoryboard(name: "Intro", bundle: nil)
                           let vc = storyboard.instantiateViewController(withIdentifier: "intro")
                           self.navigationController?.pushViewController(vc, animated: true)
                       } else {
                           self.performSegue(withIdentifier: "goToHome", sender: Auth.auth().currentUser)
                       }
                   }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? AddDetailTableViewController{
            nextVC.user = sender as? User
        }
        
//        if let nextVC = segue.destination as? CarbonLogViewController{
//            nextVC.user = sender as! User
//        }
    }
}
