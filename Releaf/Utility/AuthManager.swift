//
//  AuthManager.swift
//  Releaf
//
//  Created by Batch-2 on 04/06/24.
//

import Foundation
import Firebase

class AuthManager {
    
    func checkFirstLogin(completion: @escaping (Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        // Check if a flag exists in user profile indicating first login
        let userRef = Firestore.firestore().collection("users").document(currentUser.email!)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
