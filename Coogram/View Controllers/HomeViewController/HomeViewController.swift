//
//  HomeViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 09.12.2019.
//  Copyright © 2019 Дмитрий Власенко. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage
final class HomeViewController : UIViewController {
    var returnedData = [PostModel]()
    let storage = Storage.storage()
    let db = Firestore.firestore()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        loadPosts() {
            self.tableView.reloadData()
        }
    }

    @IBAction func openPostbuttonTapped(_ sender: UIButton) {
        let cell = sender.superview?.superview as! HomeScreenCell
        let indexPath = tableView.indexPath(for: cell)
        let storyBoard: UIStoryboard = UIStoryboard(name: "PostView", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.postData = returnedData[indexPath!.row]
        self.present(vc, animated: true, completion: nil)
    }
    @objc func updateData() {
        self.loadPosts() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}


extension HomeViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnedData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as! HomeScreenCell
        cell.configure(text: returnedData[indexPath.row].username)
        cell.mainImage.sd_setImage(with: URL(string: returnedData[indexPath.row].mainImageUrl!), placeholderImage: UIImage(systemName: "photo"), options: .allowInvalidSSLCertificates, completed: nil)
        return cell
    }
}

extension HomeViewController {
    func loadPosts(completion : @escaping () -> Void) {
        self.returnedData = []
        var post = PostModel()
        var loadedPosts = 0
        db.collection("Posts").getDocuments { (snapshot, error) in
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
                                                self.returnedData.reverse()
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
