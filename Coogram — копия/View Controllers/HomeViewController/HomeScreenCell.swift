//
//  HomeScreenCell.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 09.12.2019.
//  Copyright © 2019 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class HomeScreenCell : UITableViewCell {
    @IBOutlet weak var postName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    func configure(text : String,profilepic : UIImageView,mainpic: UIImageView){
        self.postName.text = text
        self.postName.font = UIFont(name: "18097.ttf", size: 19.0)
        self.profileImage.image = profilepic.image
        self.profileImage.layer.cornerRadius = 25
        self.mainImage.image = mainpic.image
        self.mainImage.layer.cornerRadius = 25
    }
}
