//
//  StepsInReceiptCell.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 11.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class StepsInReceiptCell : UITableViewCell {
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var ReceiptImage: UIImageView!
    @IBOutlet weak var AddImageButton: UIButton!
    func build() {
        AddImageButton.alignTextBelow()
        textViewDescription.makeBorders()
    }
    
    }

