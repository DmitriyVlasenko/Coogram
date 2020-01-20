//
//  LoginViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 15.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
final class LoginViewController : UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                else {
                    if let vc = self.storyboard?.instantiateViewController(identifier: "TabBarController"){
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
            }
    @IBAction func RegistrationButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SignUpViewController")
        vc?.modalPresentationStyle = .fullScreen
        if let viewController = vc {
        self.present(viewController, animated: true, completion: nil)
        }
    }
}
     
