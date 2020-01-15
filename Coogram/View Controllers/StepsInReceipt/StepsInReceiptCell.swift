//
//  StepsInReceiptCell.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 11.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class StepsInReceiptCell : UITableViewCell , ImagePickerDelegate, UITextViewDelegate {
    @IBOutlet weak var textViewDescription: UITextView!
    var imagepicker : ImagePicker!
    @IBOutlet weak var ReceiptImage: UIImageView!
    @IBOutlet weak var AddImageButton: UIButton!
    func didSelect(image: UIImage?) {
        self.ReceiptImage.image = image
    }
    func build(presentingvc: UIViewController) {
        self.imagepicker = ImagePicker(presentationController: presentingvc, delegate: self)
        AddImageButton.alignTextBelow()
        textViewDescription.makeBorders()
        textViewDescription.delegate = self
    }
    
    @IBAction func AddImageTapped(_ sender: UIButton) {
        self.imagepicker.present(from: sender)
        
    }
    }

