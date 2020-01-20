//
//  AddImageVIewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 10.12.2019.
//  Copyright © 2019 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class AddImageViewController : UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var receiptNameTextField: UITextField!
    var imagePicker : ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {}
        PostCreationManager.shared.mainImage  = nil
        PostCreationManager.shared.receiptName = nil
    }
    @IBAction func NextButtonTapped(_ sender: UIButton) {
       
//        if mainImage.image == UIImage(systemName: "photo") || receiptNameTextField.text == "" {
//           let alertController = UIAlertController(title: nil, message:
//                "Выберите картинку и название для рецепта!", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
//
//            self.present(alertController, animated: true, completion: nil)
//
//        }
//        else {
        let vc = self.storyboard!.instantiateViewController(identifier: "RecipePropertiesViewController")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        PostCreationManager.shared.mainImage  = mainImage.image
        PostCreationManager.shared.receiptName = receiptNameTextField.text
//        }
    }

    @IBAction func SelectImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender, index: nil)
    }
}

extension AddImageViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?, index: IndexPath?) {
        if let image = image {self.mainImage.image = image}
    }
    
    
    
}
