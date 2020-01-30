//
//  UserViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 23.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseAuth
import FirebaseFirestore
final class UserViewController : UIViewController {
    var returnedData = [PostModel]()
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = UIImage(systemName: "person.fill")
        loadUsersData()
        loadPostsForCurrentUser {
            DispatchQueue.main.async {
                self.postsCollection.reloadData()
            }
        }
    }
    @IBOutlet weak var postsCollection: UICollectionView!
    @IBAction func openPostButtonTapped(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UserCollectionViewCell
        let indexPath = postsCollection.indexPath(for: cell)
        let storyBoard: UIStoryboard = UIStoryboard(name: "PostView", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.postData = returnedData[indexPath!.row]
        self.present(vc, animated: true, completion: nil)
    }
}
extension UserViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        returnedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let index = indexPath.row + indexPath.section
        cell.caloriesLabel.text = returnedData[index].calories!
        cell.mainImage.sd_setImage(with: URL(string: returnedData[index].mainImageUrl!), placeholderImage: UIImage(systemName: "photo"), options: .allowInvalidSSLCertificates, completed: nil)
        cell.timeLabel.text = "\(String(describing: returnedData[index].hours!)) часов \(String(describing: returnedData[index].minutes!)) минут"
        cell.receipNameLabel.text = returnedData[index].receiptName!

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 1

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}
extension UserViewController {
    func loadUsersData() {
        db.collection("Users").whereField("Id", isEqualTo: currentUser as Any).getDocuments { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            else {
                for document in snapshot!.documents {
                    let data = document.data()
                    self.nameLabel.text = data["name"] as? String
                    self.usernameLabel.text = data["Username"] as? String
                }
            }
        }
    }
    
    func loadPostsForCurrentUser(completion : @escaping () -> Void) {
        self.returnedData = []
        var post = PostModel()
        var loadedPosts = 0
        db.collection("Posts").whereField("UserCreator", isEqualTo: currentUser as Any).getDocuments { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
                
            }
            else {
                for document in snapshot!.documents {
                    if let doc = document["UserCreator"] {
                        self.db.collection("Users").getDocuments { (users, error) in
                            if let err = error {
                                print(err.localizedDescription)
                            }
                            else {

                                for user in users!.documents {
                                    if user["Id"] as! String == doc as! String{
                                        post.properties = document["properties"] as? [String]
                                        post.user = doc as? String
                                        post.username = user["Username"] as? String
                                        for steps in document["DescSteps"] as! [String : Any] {
                                            let dict = steps.value as! [String : Any]
                                            post.descriptionSteps?.append(descriptionStep(image: nil, description: dict["Description"] as? String, imageURL: dict["URL"] as? String, step: dict["Step"] as? Int))
                                        }
                                        for ingridients in document["Ingridients"] as! [String : Any] {
                                                               let dict = ingridients.value as! [String : Any]
                                                               post.ingridients?.append(ingridient(name: dict["Name"] as? String, count: "swag", typeOfCounting: "3", position: 4))
                                                               }
                                        post.calories = document["Calories"] as? String
                                        post.creationDate = document["CreationDate"] as? TimeInterval
                                        post.description = document["Description"] as? String
                                        post.hours = document["Hours"] as? String
                                        post.minutes = document["Minutes"] as? String
                                        post.receiptName = document["ReceiptName"] as? String
                                        post.mainImageUrl = document["MainImageURL"] as? String
                                        post.profileImageURL = nil
                                        self.returnedData.append(post)
                                        post = PostModel()
                                        loadedPosts += 1
                                        if loadedPosts == snapshot?.documents.count {
                                            completion()
                                                           }
                                               }
                                           }
                                       }
                                   }
                               }
                           }
            }
        }
    }
}
