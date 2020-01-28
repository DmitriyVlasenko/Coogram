//
//  UserViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 23.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class UserViewController : UIViewController {
    var returnedData = [PostModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension UserViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        returnedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let index = indexPath.row + indexPath.section
        cell.caloriesLabel.text = returnedData[index].calories
        cell.mainImage.image = returnedData[index].mainImage
        cell.timeLabel.text = "\(String(describing: returnedData[index].hours)) hours \(String(describing: returnedData[index].minutes)) minutes"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}
extension UserViewController {
    func loadPostsForCurrentUser() {
        
    }
}
