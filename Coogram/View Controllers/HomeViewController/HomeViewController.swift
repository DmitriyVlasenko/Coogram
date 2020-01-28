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
final class HomeViewController : UIViewController {
    var returnedData = [PostModel]() // Rework to post model
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var group  = DispatchGroup()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }
}


extension HomeViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnedData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as! HomeScreenCell
        cell.configure(text: returnedData[indexPath.row].username, profilepic: UIImage(systemName: "person.fill"), mainpic: returnedData[indexPath.row].mainImage)
        return cell
    }
}

extension HomeViewController {
    func loadPosts() {
        db.collection("Posts").getDocuments { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            else {
                for document in snapshot!.documents {
                    if let  doc = document["MainImageURL"] {
                        
                        let httpsReference = self.storage.reference(forURL: "\(doc)")
                        self.group.enter()
                        httpsReference.getData(maxSize: 10*1024*1024) { (data, error) in
                            if let err = error {
                                print(err.localizedDescription)
                            }
                            else {
                                self.returnedData.append(<#T##newElement: PostModel##PostModel#>)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
