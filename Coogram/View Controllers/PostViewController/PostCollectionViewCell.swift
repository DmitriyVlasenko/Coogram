//
//  PostCollectionViewCell.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 22.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class PostCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var tagText: UILabel!
    @IBOutlet weak var maxWidthConstraint: NSLayoutConstraint! {
        didSet{
            maxWidthConstraint.isActive = false
        }
    }
    var maxWidth: CGFloat? = nil {
           didSet {
            if let width = maxWidth {
                if let const = maxWidthConstraint {
                    const.isActive = true
                    const.constant = width
                }
            }
       }
    }
       override func awakeFromNib() {
           super.awakeFromNib()
           
           contentView.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               contentView.leftAnchor.constraint(equalTo: leftAnchor),
               contentView.rightAnchor.constraint(equalTo: rightAnchor),
               contentView.topAnchor.constraint(equalTo: topAnchor),
               contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
               ])
       }
}
