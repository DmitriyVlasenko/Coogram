//
//  PostViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 22.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
import SDWebImage
final class PostViewController : UIViewController {
    var postData: PostModel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var receiptNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var decriptionTextView: UITextView!
    @IBOutlet weak var ingridientsTableView: SelfSizedTableView!
    @IBOutlet weak var stepsTableView: SelfSizedTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.sd_setImage(with: URL(string: postData.mainImageUrl!), placeholderImage: UIImage(systemName: "photo"), options: .progressiveLoad, completed: nil)
        receiptNameLabel.text = postData.receiptName
        usernameLabel.text = postData.username
        hoursLabel.text = "\(String(describing: postData.hours!)) часов"
        minutesLabel.text = "\(String(describing: postData.minutes!)) минут"
        caloriesLabel.text = postData.calories
        decriptionTextView.text = postData.description
        if let url = postData.profileImageURL {
            userImage.sd_setImage(with: URL(string: url), placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
        }
        else {
            userImage.image = UIImage(systemName: "person.fill")
        }
       
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        // TODO: REWORK FROM HARDCODE
        super.viewWillAppear(animated)
        var heightForSteps = 0
        for _ in 0...postData.descriptionSteps!.count - 1 {
            heightForSteps += 400
        }
        var heightForIngridients = 0
        for _ in 0...postData.ingridients!.count - 1 {
            heightForIngridients += 30
        }
        stepsTableView.heightAnchor.constraint(equalToConstant: CGFloat(heightForSteps)).isActive = true
        ingridientsTableView.heightAnchor.constraint(equalToConstant: CGFloat(heightForIngridients)).isActive = true

    }
    @IBOutlet weak var collectionlayout: UICollectionViewFlowLayout!{
        didSet {
            collectionlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

extension PostViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case ingridientsTableView:
            return postData.ingridients!.count
        case stepsTableView:
            return postData.descriptionSteps!.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case ingridientsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostIngridientTableViewCell", for: indexPath) as! PostIngridientTableViewCell
            cell.IngridientLabel.text = "\(String(describing: postData.ingridients![indexPath.row].name!))  \(String(describing: postData.ingridients![indexPath.row].count!)) \(String(describing: postData.ingridients![indexPath.row].typeOfCounting!))"
            return cell
        case stepsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDescriptionTableViewCell", for: indexPath) as! PostDescriptionTableViewCell
            cell.stepDescription.text = postData.descriptionSteps![indexPath.row].description
            cell.stepImageView.sd_setImage(with: URL(string: postData.descriptionSteps![indexPath.row].imageURL!), placeholderImage: nil, options: .progressiveLoad)
                        return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}


extension PostViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.properties!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        let index = indexPath.row + indexPath.section
        cell.tagText.text = postData.properties![index]
        cell.layer.borderWidth = 1
        cell.backgroundColor = #colorLiteral(red: 0.9384230971, green: 0.7248145938, blue: 0.4540049434, alpha: 1)
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = #colorLiteral(red: 0.9384230971, green: 0.7248145938, blue: 0.4540049434, alpha: 1)
        cell.maxWidth = collectionView.bounds.width - 5
        return cell
    }
    
    
    
}
