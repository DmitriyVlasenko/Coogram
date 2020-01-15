//
//  HomeViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 09.12.2019.
//  Copyright © 2019 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class HomeViewController : UIViewController,UITableViewDataSource,UITableViewDelegate {
    var returnedData = [HomeScreenCellModel]()
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnedData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as! HomeScreenCell
        cell.configure(text: returnedData[indexPath.row].text, profilepic: returnedData[indexPath.row].profileimage, mainpic: returnedData[indexPath.row].mainImage)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...3{
            returnedData.append(HomeScreenCellModel(mainImage: UIImageView(image: UIImage(named: "hamburger")), text: "\(i)", profileimage: UIImageView(image: UIImage(named: "profile"))))
            
        }
    }
}


