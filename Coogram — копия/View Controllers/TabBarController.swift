//
//  TabBarController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 08.12.2019.
//  Copyright © 2019 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class TabBarController : UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        self.delegate = self
        super.viewDidLoad()
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if self.tabBar.selectedItem === self.tabBar.items?[2] {
            let storyBoard: UIStoryboard = UIStoryboard(name: "AddImage", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddImageViewController") as! AddImageViewController
            newViewController.modalPresentationStyle = .fullScreen
                    self.present(newViewController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
   }


