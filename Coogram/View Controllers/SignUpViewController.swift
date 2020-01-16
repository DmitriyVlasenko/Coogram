//
//  SignUpViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 15.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
final class SignUpViewController : UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignInButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text,
            let confirmationPassword = passwordConfirmationTextField.text, let username = UsernameTextField.text {
            if password == confirmationPassword {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (data, error) in
                    if let err = error {
                        print(err.localizedDescription)
                        print("Error alert")
                    }
                    else {
                        
                        let user = Auth.auth().currentUser
                        let myUser = User(id: user!.uid, name: username, posts: nil, profilePhoto: nil)
                        self.db.collection("Users").addDocument(data: ["Id": myUser.id, "Username" : username])
                        let storageref = Storage.storage().reference()  
                        let usersStorageRef = storageref.child("users/")
                        let userPersonalFolderRef = usersStorageRef.child("\(String(describing: user!.uid))/")
                        let finishingReference = userPersonalFolderRef.child("defaultPhoto.png")
                        finishingReference.putData((UIImage(systemName: "photo")?.pngData())!, metadata: nil) { (metadata, error) in
                            
                        }
                        if let vc = self.storyboard?.instantiateViewController(identifier: "TabBarController"){
                        vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                    }
                }
                )
            }
            else {
                print("Пароли не совпадают алерт")
            }
        }
        else {
            print("Заполните все поля для регистрации алерт")
        }
        
    }
}

