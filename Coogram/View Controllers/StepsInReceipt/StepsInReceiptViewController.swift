//
//  StepsInReceiptViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 11.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
final class StepsInReceiptViewController: UIViewController {
    var receiptStepsModel : [[ReceiptStepsModel]] = [[ReceiptStepsModel()]]
    let db = Firestore.firestore()
    var imagepicker : ImagePicker!
    override func viewDidLoad() {
    super.viewDidLoad()
    imagepicker = ImagePicker(presentationController: self, delegate: self)
    }

    @IBOutlet weak var StepsTableView: UITableView!
    
    @IBAction func AddStepButtonTapped(_ sender: UIButton) {
        receiptStepsModel.append([ReceiptStepsModel()])
        StepsTableView.reloadData()
        

    }
    @IBAction func PostButtonTapped(_ sender: UIButton) {
        PostCreationManager.shared.creationDate = Date().timeIntervalSince1970
        PostCreationManager.shared.user = Auth.auth().currentUser?.uid
        var images: [UIImage] = []
        for i in 0...receiptStepsModel.count-1 {
            PostCreationManager.shared.descriptionSteps?.append(descriptionStep(image: receiptStepsModel[i][0].image, description: receiptStepsModel[i][0].desc, imageURL: nil, step: i+1))
            images.append(receiptStepsModel[i][0].image!)
        }
        uploadImagesInStorage(images: images, mainImage: PostCreationManager.shared.mainImage!) {
            let dataToUpload =  self.convertDataToDictionary(post: PostCreationManager.shared)
            self.db.collection("Posts").addDocument(data: dataToUpload)
            
            
        }
        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func AddImageButtonTapped(_ sender: UIButton) {
    let cell = sender.superview?.superview as! StepsInReceiptCell
    let indexpath = StepsTableView.indexPath(for: cell)
    imagepicker.present(from: self.view, index: indexpath!)
        
    
    }
}


extension StepsInReceiptViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let cell = textView.superview?.superview as! StepsInReceiptCell
        let indexpath = StepsTableView.indexPath(for: cell)
        receiptStepsModel[indexpath!.section][0].desc = textView.text
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        StepsTableView.reloadData()
    }
}




extension StepsInReceiptViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return receiptStepsModel.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Шаг \(section + 1)"
    }
}



extension StepsInReceiptViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsInReceiptCell", for: indexPath) as! StepsInReceiptCell
        cell.build()
        if receiptStepsModel[indexPath.section][0].isButtonHidden {
            cell.AddImageButton.alpha = 0
        }
        else {
            cell.AddImageButton.alpha = 1
        }
        cell.ReceiptImage.image = receiptStepsModel[indexPath.section][indexPath.row].image
        cell.textViewDescription.text = receiptStepsModel[indexPath.section][indexPath.row].desc
        return cell
    }
    
}



extension StepsInReceiptViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?, index: IndexPath?) {
        if let index = index {
            if let image = image {
            // TODO : Alert vc
            receiptStepsModel[index.section][0].image = image
            receiptStepsModel[index.section][0].isButtonHidden = true
            StepsTableView.reloadData()
            }
            else {
                receiptStepsModel[index.section][0].image = nil
                receiptStepsModel[index.section][0].isButtonHidden = false
                StepsTableView.reloadData()
            }
            }
        }
        
    }
    


extension StepsInReceiptViewController {
    // TODO : refactor to encode 
    func convertDataToDictionary(post: PostModel)  -> Dictionary<String, Any>{
        var docData = Dictionary<String, Any>()
        var steps = Dictionary <String , Any>()
        var stepsToDatabase = Dictionary <String , Any>()
        docData.updateValue(post.calories!, forKey : "Calories")
        docData.updateValue(post.creationDate!, forKey: "CreationDate")
        docData.updateValue(post.description!, forKey: "Description")
        docData.updateValue(post.properties!, forKey: "properties")
        for i in 0...post.descriptionSteps!.count - 1 {
            steps.updateValue(post.descriptionSteps![i].description!, forKey: "Description")
            steps.updateValue(post.descriptionSteps![i].imageURL!, forKey: "URL")
            steps.updateValue(post.descriptionSteps![i].step!, forKey: "Step")
            stepsToDatabase.updateValue(steps, forKey: "Step \(i+1)")
        }
        docData.updateValue(stepsToDatabase, forKey: "DescSteps")
        docData.updateValue(post.hours!, forKey: "Hours")
        docData.updateValue(post.minutes!, forKey: "Minutes")
        docData.updateValue(post.user!, forKey: "UserCreator")
        docData.updateValue(post.mainImageUrl!, forKey: "MainImageURL")
        var ingridients = Dictionary <String , Any>()
        var ingridientsToDatabase = Dictionary <String , Any>()
        for i in 0...post.ingridients!.count - 1 {
            ingridients.updateValue(post.ingridients![i].count!, forKey: "Count")
            ingridients.updateValue(post.ingridients![i].name!, forKey: "Name")
            ingridients.updateValue(post.ingridients![i].typeOfCounting!, forKey: "TypeOfCounting")
            ingridients.updateValue(post.ingridients![i].position!, forKey: "Position")
            ingridientsToDatabase.updateValue(ingridients, forKey: "Ingridient \(i+1)")
        }
        docData.updateValue(ingridientsToDatabase, forKey: "Ingridients")
        docData.updateValue(post.receiptName!, forKey: "ReceiptName")
        return docData
    }
}
    



extension StepsInReceiptViewController {
    func uploadImagesInStorage(images : [UIImage], mainImage : UIImage, completion : @escaping (() -> Void )) {
        if let user = Auth.auth().currentUser {
        var imagesUploaded = 0
        let storageref = Storage.storage().reference()
        let usersStorageRef = storageref.child("users/")
        let userPersonalFolderRef = usersStorageRef.child("\(String(describing: user.uid))/")
        let mainImageRef = userPersonalFolderRef.child("\(self.makeUniqueID()).png")
            let uploaddataMainImage = mainImage.pngData()
            mainImageRef.putData(uploaddataMainImage!, metadata: nil) { (metadata, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                else {
                mainImageRef.downloadURL { (url, error) in
                    PostCreationManager.shared.mainImageUrl = url?.absoluteString
                    for i in 0...PostCreationManager.shared.descriptionSteps!.count - 1 {
                        let finalReference = userPersonalFolderRef.child("\(self.makeUniqueID()).png")
                        if let uploadData = PostCreationManager.shared.descriptionSteps?[i].image?.pngData() {
                        finalReference.putData(uploadData, metadata: nil) { (metadata, error) in
                            if let err = error {
                                print(err.localizedDescription)
                            }
                            else {
                                finalReference.downloadURL { (StepUrl, error) in
                                    if let err = error {
                                        print(err.localizedDescription)
                                    }
                                    else {
                                        imagesUploaded += 1
                                        PostCreationManager.shared.descriptionSteps?[i].imageURL = StepUrl?.absoluteString
                                        if imagesUploaded == images.count {
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
    }
}
