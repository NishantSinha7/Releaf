import UIKit
import SceneKit
import FirebaseAuth
import FirebaseFirestore

class EcoSphereViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    var globeNode: SCNNode!
    var progress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .ecoBg
        
        let scene = SCNScene()
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0.5, z: 4.5)
        scene.rootNode.addChildNode(cameraNode)
        
        globeNode = SCNNode(geometry: SCNSphere(radius: 1))
        globeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth_texture_2")
        scene.rootNode.addChildNode(globeNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        sceneView.scene = scene

        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "") { userData in
            self.loadTrees()
        }
        setupTopInfoView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReleafData.shared.getUserData(with: Auth.auth().currentUser?.email ?? "") { userData in
            self.loadTrees()
        }
        setupTopInfoView()
    }

    func setupTopInfoView() {
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .seaGreen
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        progress = Float(Float(ReleafData.shared.userData.totalTreePlanted) / 500.0)
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let treesPlantedLabel = UILabel()
        treesPlantedLabel.translatesAutoresizingMaskIntoConstraints = false
        treesPlantedLabel.text = "Trees You Planted"
        treesPlantedLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        treesPlantedLabel.textColor = .myDarkGreen
        
        let treeCountLabel = UILabel()
        treeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        treeCountLabel.text = "\(ReleafData.shared.userData.totalTreePlanted)"
        treeCountLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        treeCountLabel.textColor = .myDarkGreen
        
        let co2Label = UILabel()
        co2Label.translatesAutoresizingMaskIntoConstraints = false
        co2Label.text = "🌿\n\(ReleafData.shared.userData.virtualCurrency)"
        co2Label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        co2Label.textAlignment = .right
        co2Label.numberOfLines = 2
        co2Label.textColor = .myDarkGreen
        
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = progress
        progressView.trackTintColor = .lightGray.withAlphaComponent(0.4)
        progressView.progressTintColor = .myDarkGreen
        
        let nextTreeLabel = UILabel()
        nextTreeLabel.translatesAutoresizingMaskIntoConstraints = false
        nextTreeLabel.text = "Habitability \(Int(progressView.progress * 100.0))%"
        nextTreeLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nextTreeLabel.textColor = .myDarkGreen
        
        containerView.addSubview(treesPlantedLabel)
        containerView.addSubview(treeCountLabel)
        containerView.addSubview(co2Label)
        containerView.addSubview(nextTreeLabel)
        containerView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            treesPlantedLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            treesPlantedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            treeCountLabel.topAnchor.constraint(equalTo: treesPlantedLabel.bottomAnchor, constant: 4),
            treeCountLabel.leadingAnchor.constraint(equalTo: treesPlantedLabel.leadingAnchor),
            
            co2Label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            co2Label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            nextTreeLabel.topAnchor.constraint(equalTo: treeCountLabel.bottomAnchor, constant: 16),
            nextTreeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            progressView.topAnchor.constraint(equalTo: nextTreeLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            progressView.heightAnchor.constraint(equalToConstant: 10), // Adjust the height as needed
        ])
    }

    @IBAction func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let cameraNode = sceneView.pointOfView else { return }
        var zoom = cameraNode.camera?.orthographicScale ?? 1.0
        zoom /= Double(gesture.scale)
        cameraNode.camera?.orthographicScale = zoom
        gesture.scale = 1.0
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let location = gestureRecognize.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: [:])
        if let hit = hitResults.first {
            let hitPosition = hit.worldCoordinates
            if ReleafData.shared.userData.virtualCurrency >= 5 {
                addTree(at: hitPosition)
            }
            else{
                let alertController = UIAlertController(title: "Not Enough Currency", message: "Please take more actions to earn more currency and plant trees", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                        }
                        alertController.addAction(okAction)
                        
                        present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func addTree(at position: SCNVector3) {
            let treeScene = SCNScene(named: "Coconut_Tree.usdz")!
            let treeNode = treeScene.rootNode.childNode(withName: "scene", recursively: false)!
            
            let scaleFactor: Float = 0.0001
            treeNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
            treeNode.position = position
            globeNode.addChildNode(treeNode)
            
            updateUserData(with: Auth.auth().currentUser?.email ?? "", updatedCurrency: (ReleafData.shared.userData.virtualCurrency) - 5, totalTrees: (ReleafData.shared.userData.totalTreePlanted) + 1)
            ReleafData.shared.userData.virtualCurrency -= 5
            ReleafData.shared.userData.totalTreePlanted += 1
            
            saveTreePosition(email: Auth.auth().currentUser?.email ?? "", position: position)
            
            setupTopInfoView()
        }

    
    func updateUserData(with emailID: String, updatedCurrency: Int, totalTrees: Int) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(emailID)
        
        userRef.updateData([
            "virtualCurrency": updatedCurrency,
            "totalTreePlanted": totalTrees
        ]) { error in
            if let error = error {
                print("Error updating user data: \(error)")
            } else {
                print("User data updated successfully")
            }
        }
    }
    
    func saveTreePosition(email: String, position: SCNVector3) {
        let db = Firestore.firestore()
        let treeData: [String: Any] = [
            "x": position.x,
            "y": position.y,
            "z": position.z
        ]
        
        db.collection("users").document(email).collection("trees").addDocument(data: treeData) { error in
            if let error = error {
                print("Error saving tree position: \(error)")
            } else {
                print("Tree position saved successfully")
            }
        }
    }
    
    func loadTrees() {
        guard let email = Auth.auth().currentUser?.email else { return }
        let db = Firestore.firestore()
        let treesRef = db.collection("users").document(email).collection("trees")
        
        treesRef.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching tree positions: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else { return }
            
            for document in documents {
                let data = document.data()
                if let x = data["x"] as? Float,
                   let y = data["y"] as? Float,
                   let z = data["z"] as? Float {
                    let position = SCNVector3(x, y, z)
                    self.addTreeNode(at: position)
                }
            }
        }
    }
    
    func addTreeNode(at position: SCNVector3) {
        let treeScene = SCNScene(named: "Coconut_Tree.usdz")!
        let treeNode = treeScene.rootNode.childNode(withName: "scene", recursively: false)!
        
        let scaleFactor: Float = 0.0001
        treeNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        treeNode.position = position
        globeNode.addChildNode(treeNode)
    }
}
